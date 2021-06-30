class RemoveForeignKeyOfPostsFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :posts do |t|
      t.remove_references :user
    end
  end
end
