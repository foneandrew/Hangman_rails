class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :secret_word
      t.timestamps
    end
  end
end
