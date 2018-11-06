class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text      :description
      t.integer   :rating

      t.timestamps null: false
      t.references :user, index: true, foreign: true
      t.references :product, index: true, foreign: true

    end
  end
end
