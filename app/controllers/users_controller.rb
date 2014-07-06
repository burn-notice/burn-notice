class UsersController < ApplicationController
  before_action :authenticate_current_user!
end
