class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @title = title_text
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
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

  def edit
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
private
  def title_text
    "Sign up"
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
