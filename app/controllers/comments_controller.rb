class CommentsController < ApplicationController
  before_filter :load_commentable

  TWILIO_SID = 'AC19f56d8782421ab57fe7ac71d998b714'
  TWILIO_AUTH = 'e6d037c71b9924019d62160d15949bb7'
  TWILIO_NUMBER = "+12132238913"
  
  def index
    @comments = @commentable.comments
    @commenters = User.where(id: [@comment.commenter_id])
  end

  def new
    @comment = @commentable.comments.new
  end
  
  def create
    @comment = @commentable.comments.new(comment_params)
    @exchange = Exchange.find_by(id: @comment.commentable_id)
    @user = User.find_by(id: @exchange.user_id)
    @comment.commenter_id = current_user.id
    if @comment.save
      redirect_to @commentable, notice: "Counter offer created."
      # FOR TWILIO
      @twilio_client = Twilio::REST::Client.new(
      TWILIO_SID,
      TWILIO_AUTH
      )
      @twilio_client.account.sms.messages.create(
      :from => TWILIO_NUMBER,
      :to => "+1#{@user.phone_number}",
      :body => "You have a new counteroffer: " + "$" + "#{@comment.counterprice}. Click here: www.sendangel.in/exchanges/#{@comment.commentable_id}",
      ) 
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to exchange_path(@exchange)
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:counterprice, :commenter_id)
  end

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end