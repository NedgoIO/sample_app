require 'spec_helper'


describe "Static pages" do
  subject { page }

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_title_tag full_title('About')
    click_link "Help"
    page.should have_title_tag full_title('Help')
    click_link "Contact"
    page.should have_title_tag full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_title_tag full_title('Sign up')
    click_link "Loud RoR Labs"
    page.should have_title_tag full_title('')
  end

  shared_examples_for "all static pages" do
    it { should have_header_tag heading}
    it { should have_title_tag( full_title(page_title)) }
  end
  describe "Home page"  do
    before { visit root_path }
    let(:heading) { 'Sorry!' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    it { should_not have_title_tag( ' | Home') }

  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About Us' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact Us' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end
end
