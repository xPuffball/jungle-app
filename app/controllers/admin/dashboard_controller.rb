class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"].to_s, password: ENV["HTTP_BASIC_PASSWORD"].to_s

  def show
    @products = Product.count
    @categories = Category.count
  end
end
