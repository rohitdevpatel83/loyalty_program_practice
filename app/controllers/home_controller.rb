class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @spending = Spending.new
    @loyalty_points = current_user.loyalty_points.where("expiry > ?", DateTime.now).where.not(reward_title: "standard")
  end
end
