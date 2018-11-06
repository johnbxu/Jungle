class ReviewsController < ApplicationController
  before_filter :authorize
  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.product_id = params[:product_id]
    if review.save
      redirect_to '/'
    else
      puts review.errors.inspect
      redirect_to '/'
    end
    # @review = Review.new(product: @product)
    # @review.save
    #
    # if @review.valid?
    #   redirect_to @product
    # end

  end

  private
    def review_params
      params.require(:review).permit(:description, :rating, :user_id, :product_id)
    end
end
