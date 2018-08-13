class Api::V1::TransactionsController < ApplicationController
  def new

  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.create
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender, :receiver, :amount)
  end
end
