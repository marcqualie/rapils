class CreateAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.references :user, type: :uuid
      # t.string :type, default: 'AccessToken', null: false
      t.string :name, null: false
      t.string :token, null: false
      t.string :actions, default: [], null: false, array: true
      t.datetime :last_used_at
      t.datetime :expires_at
      t.datetime :invalidated_at
      t.timestamps null: false

      t.index %i[token], name: 'index_access_tokens_on_token', unique: true
    end
  end
end
