require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up Now!")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @usr = Factory(:user)
    end
    
    it "should be success" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do

      puts "before calling GET :show, : #{@usr.id}, #{@usr.name}, #{@usr.email}"

      # get 'show' is equivalent to get :show
      # id => @user is automatically converted by Rails to: :id => @user.id
      get :show, :id => @usr
      
      # 'assigns' is a RSpec facility from Test::Unit library
      # takes a symbol and returns the value of the corresponding instance variable in the controller action
      assigns(:user).should == @usr
    end
  end
end
