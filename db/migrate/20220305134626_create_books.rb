class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.string :author

      t.timestamps
    end
  end
end
