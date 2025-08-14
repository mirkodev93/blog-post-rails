class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :author, null: false

      t.timestamps
    end
  end
end
