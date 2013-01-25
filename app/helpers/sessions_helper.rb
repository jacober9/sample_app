module SessionsHelper

	 # Listing 8.19 "complete (but not-yet-working) sign_in function"
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token # really expires in 20 years
    self.current_user = user
  end

  # Listing 8.23 - in preparation for view
  def signed_in?
    !current_user.nil?
  end

  # Listing 8.30 - by symmetry with sign_in
  def sign_out
    self.current_user = nil
    cookies.delete :remember_token
  end

  # Listing 8.20 current_user wasn't even defined. did that really merit a section break??
  def current_user=(user)
    @current_user = user
  end

  # Listing 8.22 - need to REMEMBER user! can't just use attr_accessor
  def current_user
    @current_user ||= User.find_by_remember_token cookies[:remember_token]
  end
	
end
