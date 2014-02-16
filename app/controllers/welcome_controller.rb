class WelcomeController < ApplicationController

  def index
    render :index
  end  

  def account
    render :account
  end

  def about
    @angel = Angel.new
    render :about
  end

end  