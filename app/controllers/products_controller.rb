class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.sort {|x, y| x.created_at > y.created_at ? -1 : 1 }
    @review = Review.new
    @average_rating = (@reviews.reduce(0){|memo, obj| memo + obj.rating}.to_f / @reviews.length).round(1)
  end

end
