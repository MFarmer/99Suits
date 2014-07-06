class Api::CommentsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @comments = @item.comments
    render "comments/index"
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      render :json => @comment
    else
      render :json => @comment.errors, :status => :unprocessable_entity
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render "comments/show"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render "comments/show"
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render "comments/show"
    else
      render :json => @comment.errors, :status => :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :item_id, :user_id)
  end

end