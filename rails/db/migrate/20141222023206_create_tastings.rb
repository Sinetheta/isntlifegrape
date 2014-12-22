class CreateTastings < ActiveRecord::Migration
  def change
    create_table :tastings do |t|
      t.string :title

      t.timestamps
    end
  end
end
