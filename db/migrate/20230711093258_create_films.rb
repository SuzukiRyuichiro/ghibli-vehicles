class CreateFilms < ActiveRecord::Migration[7.0]
  def change
    create_table :films do |t|
      t.string :title
      t.string :image_url
      t.string :description
      t.string :director

      t.timestamps
    end
  end
end
