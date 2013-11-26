class UsersController < ApplicationController

  self.before_action( :authenticated!, :set_user, :authorized!, except: [:new, :create] )

  def show
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    # can't do a redirect or else we'll lose our new object. must use render: new
    # need this when you're grabbing user input to create a new model.
    @user = User.new(user_params)
    # @user = User.find(params[:id])

    if @user.save
      redirect_to user_path(@user) 
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end 

  def destroy
    if @user.destroy
      redirect_to new_user_path
    else 
      render :edit
    end
  end

private

# this is the white list engineering
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def logged_in?
    session[:user_id].present?
  end

# this checks for authentication, if not logged in, kick them back to log in page.

  def set_user
    @user = User.find(params[:id])
  end

# prevents users from tampering or seeing with other user accounts. is the user that's logged in, the same as the resource they're trying to access? if not, send them back to their page.
  def authorized!
    unless @user.id == session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end
end





