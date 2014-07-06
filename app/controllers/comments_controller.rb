class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    item = Item.find(params[:item_id])
    @comment = item.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to item_url(item.id)
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
