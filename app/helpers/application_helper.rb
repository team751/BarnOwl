module ApplicationHelper
  def current_user_if_exists
    if current_user
      current_user
    else
      User.new
    end
  end
end
