class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user.type_user == Role::COACH
      if current_user.accounts.count > 0
        coach_path
      else
        account_error_path
      end
    elsif current_user.type_user == Role::ADMIN
      edit_user_registration_path(current_user)
    else
      players_path(:player => current_user.id)
    end
  end
end
