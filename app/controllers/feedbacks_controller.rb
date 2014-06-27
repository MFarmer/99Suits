class FeedbacksController < ApplicationController

  def new
    @order = Order.find(params[:order_id])
    @feedback = Feedback.new
  end

  def create
    @order = Order.find(params[:order_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.order_id = @order.id

    if @feedback.save
      flash.now[:notice] = "You feedback has been submitted. Thanks!"
      redirect_to account_leave_feedback_url
    else
      flash.now[:errors] = @feedback.errors.full_messages
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating, :content)
  end

end
