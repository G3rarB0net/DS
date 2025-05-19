class CreateTareas < ActiveRecord::Migration[8.0]
  def change
    create_table :tareas do |t|
      t.string :descripcion
      t.boolean :completada
      t.string :usuario
      t.integer :tarea_padre_id

      t.timestamps
    end
  end
end
