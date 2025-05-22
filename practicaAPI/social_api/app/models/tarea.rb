class Tarea < ApplicationRecord
  has_many :asignacion_tareas, dependent: :destroy
  has_many :users, through: :asignacion_tareas
end

