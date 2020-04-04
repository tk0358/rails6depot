class CreatePaysTable < ActiveRecord::Migration[6.0]
  def change
    create_table :pays do |t|
      t.string :way, null: false
    end
  end
end
