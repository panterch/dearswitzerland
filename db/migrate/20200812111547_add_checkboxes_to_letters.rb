class AddCheckboxesToLetters < ActiveRecord::Migration[6.0]
  def change
    add_column :letters, :terms, :boolean
    add_column :letters, :privacy, :boolean
    add_column :letters, :over_15, :boolean
  end
end
