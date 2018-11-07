class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.product_id = params[:product_id]
    if review.save
      redirect_to :back
    else
      puts review.errors.inspect
      redirect_to '/'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back, notice: 'Review deleted!'
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating, :user_id, :product_id)
    end
end
