class RemoveUsuarioFromTareas < ActiveRecord::Migration[8.0]
  def change
    remove_column :tareas, :usuario, :string
  end
end
