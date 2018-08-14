class Api::V1::TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = Transaction.all
  end

  def create
    @user = current_user
    @transaction = Transaction.new(transaction_params)
    @transaction.sender = current_user.username
    @transaction.receiver = User.find(params[:transaction][:receiver_id]).username
    transfer_logic(params[:transaction][:receiver_id], @transaction.amount)
    puts @transaction
    @transaction.save
    redirect_to api_v1_transactions_url
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
