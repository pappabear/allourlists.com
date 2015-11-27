class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :list_id
      t.boolean :password_is_temp
      t.datetime :sent_at
      t.datetime :accepted_at

      t.timestamps null: false
    end
  end
end
