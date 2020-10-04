class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
	  t.string :title
	  t.date :release_date
	  t.integer :price
	  t.string :image_id
      t.text :remarks
      t.string :user_id
      t.string :game_id

      t.timestamps
    end
  end
end
