class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :author_id
      t.integer :subject_id
      t.integer :overall_rating
      t.integer :location_rating
      t.integer :value_rating
      t.integer :facilities_rating
      t.integer :cleanliness_rating
      t.string  :headline
      t.text    :details
      t.timestamps null: false
    end
    add_index :reviews, :author_id
    add_index :reviews, :subject_id
  end
end
