class CreateAsignacionTareas < ActiveRecord::Migration[8.0]
  def change
    create_table :asignacion_tareas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tarea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
