class AddRentalPeriodToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :from_month, :integer
    add_column :reviews, :to_month, :integer
    add_column :reviews, :from_year, :integer
    add_column :reviews, :to_year, :integer
  end
end
