class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    if @product.reviews.any?
      @reviews = @product.reviews.sort {|x, y| x.created_at > y.created_at ? -1 : 1 }
      @average_rating = (@reviews.reduce(0){|memo, obj| memo + obj.rating}.to_f / @reviews.length).round(1)
    end
    @review = Review.new
  end

end
