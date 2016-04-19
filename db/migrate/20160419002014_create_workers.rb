class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :username
      t.string :email
      t.string :password_encrypted, :null => false
      t.string :salt
      t.integer :admin, :null => false, :default => 0
      t.timestamps null: false
    end
  end
end
