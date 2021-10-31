class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.bigint :sender_id, null: false
      t.bigint :recipient_id, null: false
      t.text :content, null: false

      t.timestamps
    end
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
