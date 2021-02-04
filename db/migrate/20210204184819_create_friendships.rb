class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user_a, class_name: 'User', index: true, null: false
      t.references :user_b, class_name: 'User', index: true, null: false

      t.timestamps
    end
  end
end
