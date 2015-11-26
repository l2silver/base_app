class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :activation_digest
      t.string :remember_digest
      t.boolean :activated

      t.timestamps null: false
    end
  end
end
