class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :sender, class_name: 'User', index: true, null: false
      t.references :receiver, class_name: 'User', index: true, null: false
      t.float :amount, null: false, default: 0
      t.text :description

      t.timestamps
    end
  end
end
