class User < ApplicationRecord
  has_many :asignacion_tareas
  has_many :tareas, through: :asignacion_tareas
end
