class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @spending = Spending.new
  end
end
