class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :login
      t.string :crypted_password
      t.string :crypted_salt
      t.string :persistence_token
      t.string :single_access_token
      t.string :perishable_token
      t.integer :login_count, default: 0, null: false
      t.integer :failed_login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.boolean :active, default: false
      t.boolean :approved, default: false
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :persistence_token, unique: true
    add_index :users, :single_access_token, unique: true
    add_index :users, :perishable_token, unique: true
  end
end
