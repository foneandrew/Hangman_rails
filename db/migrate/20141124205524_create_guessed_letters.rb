class CreateGuessedLetters < ActiveRecord::Migration
  def change
    create_table :guessed_letters do |t|
      t.string :letter
      t.integer :game_id
      t.index :game_id
      t.timestamps
    end
  end
end
