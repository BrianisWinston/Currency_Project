class Api::V1::TransactionsController < ApplicationController
  def new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    transfer_logic(@transaction.receiver_id, @transaction.amount)
    @transaction.create
    render api_v1_users_url
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender, :receiver_id, :amount)
  end
end
