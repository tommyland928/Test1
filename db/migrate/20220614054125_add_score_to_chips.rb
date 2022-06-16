class AddScoreToChips < ActiveRecord::Migration[7.0]
  def change
    add_column :chips, :score, :integer
  end
end
