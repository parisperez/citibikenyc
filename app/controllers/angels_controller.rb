class AngelsController < ApplicationController
  self.before_action( :set_user, :authorized! )

  def new
  end

  def create
    @angel = Angel.new(angel_params)
    if @angel.save
      redirect_to about_path, notice: "Thank you. Your form has been submitted."
    end
  end

  def index
    @angels = Angel.all
  end

  private

  def angel_params
      params.require(:angel).permit(:firstname, :lastname, :email, :info, :twitter)
  end

  def set_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to root_path  
    end
  end

  def authorized! 
    unless user_signed_in?  && @user.email == 'parisliahyun@gmail.com'
      redirect_to root_path  
    end
  end

end