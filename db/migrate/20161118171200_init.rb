class Init < ActiveRecord::Migration[5.0]
  def change
    create_table :users  do |t|

      # for admin
      t.boolean :admin, null: false, default: false

      # for user
      t.string :email, null: false
      t.string :name, null: false
      t.string :image
      t.string :password_digest, null: false
      t.string :remember_digest

      # for fb
      t.string :fb_uid
      t.text :fb_token
      t.datetime :fb_expires_at

      t.index :email, unique: true

      t.timestamps null: false
    end

  end
end
