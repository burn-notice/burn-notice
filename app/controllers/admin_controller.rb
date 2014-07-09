class AdminController < ApplicationController
  def login
    if current_user && current_user.admin?
      session[:is_admin] = true
      redirect_to bhf.root_url
    else
      redirect_to(root_path, notice: 'You are not supposed to see that!')
    end
  end
end
