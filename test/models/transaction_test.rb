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

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
