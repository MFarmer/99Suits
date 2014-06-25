class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to item_url(params[:comment][:item_id])
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :item_id)
  end

end
