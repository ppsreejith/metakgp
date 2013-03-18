def sign_in(user)
  visit signin_path
  fill_in "Roll no",    with: user.roll_no
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end