require 'spec_helper'

describe PagesController do
  render_views
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should contain Home" do
      get 'home'
      response.should have_selector("title", :content => "Sample App | Home")
    end

    it "should contain head text" do
      get 'home'
      response.should contain ('head text')
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

end
