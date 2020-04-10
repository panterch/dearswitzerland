class AddSlugToLetters < ActiveRecord::Migration[6.0]
  def change
    add_column :letters, :slug, :string, null: false
    add_index :letters, :slug, unique: true
  end
end
