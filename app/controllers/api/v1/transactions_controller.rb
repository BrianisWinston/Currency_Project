class Api::V1::TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = Transaction.all
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.amount < current_user.credits
      @transaction.sender = current_user.username
      @transaction.receiver = User.find(params[:transaction][:receiver_id]).username
      transfer_logic(params[:transaction][:receiver_id], @transaction.amount)
      @transaction.save
      redirect_to api_v1_transactions_url
    else
      login(current_user)
      flash[:errors] = "You do not have enough credits to send. Please check and try again."
      redirect_to api_v1_users_url
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
