class UsersController < ApplicationController
  def new
    @title = title_text
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = title_text
      render 'new'
    end
  end

private
  def title_text
    "Sign up"
  end

end
