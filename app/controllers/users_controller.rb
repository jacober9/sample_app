class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :signed_in, only: [:new, :create]
  before_filter :self_destroy, only: :destroy
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Signed Up Successfully, Welcome to the Sample App!"
      redirect_to @user
  	else
  		render 'new'
  	end  	
  end
  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @name= User.find(params[:id]).name 
    User.find(params[:id]).destroy
    flash[:success] = "#{@name} was destroyed."
    redirect_to users_url
  end

  private
    def signed_in
      unless !signed_in?
        redirect_to(root_path)
      end
    end

    def correct_user
      @user=User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def self_destroy
      @user = User.find(params[:id])
      if @user.id == current_user.id
        redirect_to users_path, notice: "I wont let you kill yourself!"
      end
    end
end
