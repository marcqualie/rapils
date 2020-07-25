class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions, id: :uuid do |t|
      t.references :owner, type: :uuid, polymorphic: true
      t.references :subject, type: :uuid, polymorphic: true
      t.string :actions, array: true, null: false, default: []
      t.boolean :recursive, default: false, null: false
      t.datetime :expires_at
      t.timestamps null: false
    end
  end
end
