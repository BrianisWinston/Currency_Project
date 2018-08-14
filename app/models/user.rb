# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  credits         :float            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  #Making sure the user going into the database has a session token
  before_validation :ensure_session_token

  #Model level validations in order to prevent the database from crashing
  #and to display errors in view
  validates :username, :email, :password_digest, :session_token, :credits, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :email, uniqueness: true

  #In order to set and manipulate password instance variable
  attr_reader :password

  #For session controller to find user to generate a new session
  def self.find_by_credentials(username, pw)
    user = User.find_by(username: username)
    user && user.is_password?(pw) ? user : nil
  end

  #Password that is passed in will not be saved to database
  #but a hashing function will create a password digest
  #to save to the database to ensure security of account
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  #For login logic, passed in hash function to validate password digest
  #is the same as the one saved to database
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  #When creating a user, ensure they have a session token saved to the
  #database to login after being created
  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  #To create or destroy a session for a user so another user does
  #get access to personal data
  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

end
