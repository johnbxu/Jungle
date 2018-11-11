class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  # mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true
  validates :quantity, numericality: { greater_than: -1 }

end
