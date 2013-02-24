include ApplicationHelper
def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"

  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def valid_signup
  fill_in "Name", with: "Example User"
  fill_in "Email", with: "example@user.org"
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_title_tag do |title|
  match do |page|
    page.should have_selector('title', text: title)
  end
end

RSpec::Matchers.define :have_header_tag do |header|
  match do |page|
    page.should have_selector('h1', text: header)
  end
end

RSpec::Matchers.define :have_list_tag do |list|
  match do |page|
    page.should have_selector('li', text: list)
  end
end