class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email, null: false
      t.string :admin_roles, array: true, default: []
      t.string :auth0_uid, null: false
      t.datetime :access_granted_at
      t.timestamps null: false

      t.index %i[auth0_uid], name: 'index_users_on_auth0_uid', unique: true
      t.index %i[email], name: 'index_users_on_email', unique: true
    end
  end
end
