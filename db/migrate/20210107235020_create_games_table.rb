class CreateGamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :result
      t.string :game_type
      t.references :user
    end
  end
end
