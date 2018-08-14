class Api::V1::TransactionsController < ApplicationController
  #Ensure user is logged in before a transaction is created
  before_action :require_login

  #Put all transactions in instance variable for views to manipulate
  def index
    @transactions = Transaction.all
  end

  #Create a transaction variable with whitelisted values from view,
  #have if statement to handle logic depending on amount of credits
  #for transaction
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.amount < 0
      flash[:errors] = "You cannot put a negative amount. Please check and try again."
      redirect_to api_v1_users_url
    elsif @transaction.amount < current_user.credits
      @transaction.sender = current_user.username
      @transaction.receiver = User.find(params[:transaction][:receiver_id]).username
      transfer_logic(params[:transaction][:receiver_id], @transaction.amount)
      @transaction.save
      redirect_to api_v1_transactions_url
    else
      flash[:errors] = "You do not have enough credits to send. Please check and try again."
      redirect_to api_v1_users_url
    end
  end

  private

  #Keep code organized and hide params logic for best controller practice
  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
