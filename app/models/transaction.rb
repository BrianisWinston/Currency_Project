# == Schema Information
#
# Table name: transactions
#
#  id         :bigint(8)        not null, primary key
#  sender     :string           not null
#  receiver   :string           not null
#  amount     :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Transaction < ApplicationRecord
  #Make sure all attributes are present to prevent database crash
  validates :sender, :receiver, :amount, presence: true
end
