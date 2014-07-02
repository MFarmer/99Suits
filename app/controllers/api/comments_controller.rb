class Api::CommentsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    render :json => @comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render :json => @comment
    else
      render :json => @comment.errors, :status => :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :item_id, :user_id)
  end

end