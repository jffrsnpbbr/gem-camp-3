class Admin::UsersController < ApplicationController
  def index
    @users = User.page params[:pages]
  end

  def check_admin
    raise ActionController::RoutingError.new('Not found') unless
    current_user.admin?
  end
end
