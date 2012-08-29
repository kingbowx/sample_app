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
      response.should have_selector("title", :content => "Sign up")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @usr = Factory(:user)
    end
    
    it "should be success" do
      get :show, :id => @usr
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
    
    it "should include the user's name'" do
      get :show, :id => @usr
      response.should have_selector("h1", :content =>@usr.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @usr
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
  
  describe "POST 'create' " do
    before(:each) do
      @attr = {:name => "", :email => "", :password => "", :password_confirmation => "" }
    end
    
    it "should not create a user" do
      lambda do
        post :create, :user => @attr
      end.should_not change(User, :count)
    end
    
    it "should have the right title" do
      post :create, :user => @attr
      response.should have_selector("title", :content => "Sign up")
    end
    
    it "should render the new page" do
      post :create, :user => @attr
      response.should render_template('new') # render_template is a RSpec method
    end
  end
end
