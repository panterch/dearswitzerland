class AddTokenAndIndexesToLetters < ActiveRecord::Migration[6.0]
  def change
    add_column :letters, :token, :string, null: false
    add_index :letters, :catalog
    add_index :letters, :lang
    add_index :letters, :status
    add_index :letters, :token, unique: true
  end
end
