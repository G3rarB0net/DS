class Tarea < ApplicationRecord
  belongs_to :tarea_padre, class_name: "Tarea", optional: true
  has_many :subtareas, class_name: "Tarea", foreign_key: "tarea_padre_id", dependent: :destroy

  validates :descripcion, presence: true
end

