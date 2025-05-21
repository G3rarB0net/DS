class CreateAmistads < ActiveRecord::Migration[8.0]
  def change
    create_table :amistads do |t|
      t.string :usuario
      t.string :amistadCon

      t.timestamps
    end
  end
end
