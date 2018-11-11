class Order < ActiveRecord::Base
  after_save :update_quantity

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true
  private
    def update_quantity
      self.line_items.each do |entry|
        entry.product.quantity -= entry.quantity
        entry.product.save!
      end
    end
end
