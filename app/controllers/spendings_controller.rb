class SpendingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spending = Spending.new
  end

  def create
    @spending = Spending.new(spending_params)
    @spending.user = current_user
    @spending.save
    flash[:notice] = 'Successfully spent!'
    redirect_to root_path
  end

  private

  def spending_params
    params.require(:spending).permit(:amount, :foreign_spending)
  end
end
