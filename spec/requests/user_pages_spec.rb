require 'spec_helper'

describe "User Pages" do
  subject { page }
  describe "signup page" do
    before { visit signup_path }

    it { should have_header_tag('Sign Up') }

    it { should have_title_tag('Sign up') }
  end

  describe "profile page" do
    # Code to make a user variable
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_header_tag(user.name ) }

    it { should have_title_tag(user.name ) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account" }
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title_tag('Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { valid_signup }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving user" do
        before { click_button submit }
        let(:user) { User.find_by_email('example@user.org') }

        it { should have_title_tag(user.name) }
        it { should have_success_message('Welcome') }
        it { should have_link('Sign out') }
      end

    end
  end

end
