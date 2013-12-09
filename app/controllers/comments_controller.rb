class CommentsController < ApplicationController

  before_filter :load_commentable
  def create
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable }
      else
        format.html { render :action => 'new' }
      end
    end
  end

   def get_user
    @user = User.find(params[:commentable_id])
  end

  def index
    @user = User.find(params[:commentable_id])
    @comments = @user.comment.all # or sorted by date, or paginated, etc.
  end

  protected

  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end




end