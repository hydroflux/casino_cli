class CreateWarsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :wars do |t|
      t.string :result
    end
  end
end
