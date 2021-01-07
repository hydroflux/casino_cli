class CreateWargamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :war_games do |t|
      t.references :war
      t.references :user
    end
  end
end
