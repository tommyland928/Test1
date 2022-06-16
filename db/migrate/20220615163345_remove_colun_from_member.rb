class RemoveColunFromMember < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :nickname, :string
  end
end
