class Api::ItemsController < ApplicationController

  def index
    @items = Item.all

    @items.each do |item|
      item.photo_file_name = item.photo.url(:medium)
      item.photo_content_type = item.user.avatar.url(:thumb)
    end

    render :json => @items
  end

  def show
    @item = Item.find(params[:id])
    render :json => @item
  end

  def create
    @item = Item.new(params[:id])

    if @item.save
      render :json => @item
    else
      render :json => @item.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      render :json => @item
    else
      raise "Error in Item Destroy Action"
    end
  end
end
