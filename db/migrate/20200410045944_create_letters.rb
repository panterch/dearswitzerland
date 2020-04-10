class CreateLetters < ActiveRecord::Migration[6.0]
  def change
    create_table :letters do |t|
      t.string :name
      t.string :email
      t.string :age
      t.string :canton
      t.string :lang
      t.boolean :catalog
      t.boolean :publish_name
      t.boolean :publish_age
      t.boolean :publish_canton
      t.boolean :recall
      t.boolean :newsletter
      t.integer :status
      t.timestamps
    end
  end
end
