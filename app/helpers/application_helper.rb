module ApplicationHelper
  def user_signed_in?
    session[:user_data].present?
  end
end
