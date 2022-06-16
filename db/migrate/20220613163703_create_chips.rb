class CreateChips < ActiveRecord::Migration[7.0]
  def change
    create_table :chips do |t|
      t.integer :green
      t.integer :blue
      t.integer :red
      t.integer :black

      t.timestamps
    end
  end
end
