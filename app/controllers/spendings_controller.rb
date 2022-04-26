class SpendingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spending = Spending.new
  end

  def create
    Spending.create(user: current_user, amount: spending_params[:amount])
  end

  private

  def spending_params
    params.require(:spending).permit(:amount)
  end
end
