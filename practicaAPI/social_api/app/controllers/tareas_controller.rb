class TareasController < ApplicationController
  before_action :set_tarea, only: [:show, :update, :destroy]

 def index
    if params[:usuario].present?
      usuario = User.find_by(email: params[:usuario])
      @tareas = usuario ? usuario.tareas : []
    else
      @tareas = Tarea.all
    end
    
     render json: @tareas.to_json(include: { users: { only: [:email] } })
  end

  
  def show
    render json: @tarea.as_json
  end

  
  def create
    @tarea = Tarea.new(tarea_params)
    if @tarea.save
      asignar_usuarios(@tarea)
      render json: @tarea, status: :created
    else
      render json: @tarea.errors, status: :unprocessable_entity
    end
  end

 
  def update
   
    if @tarea.update(tarea_params)
      asignar_usuarios(@tarea)
      render json: @tarea
    else
      render json: @tarea.errors, status: :unprocessable_entity
    end
  end

  def destroy
    
    if @tarea.destroy
      head :ok
    else
      render json: { error: "No se pudo eliminar" }, status: :unprocessable_entity
    end
  end
  
  def usuarios_asignados
    tarea = Tarea.find(params[:id])
    usuarios = tarea.users
    render json: usuarios.as_json(only: [:id, :email, :name])
  end
  
  

  private

  def set_tarea
    @tarea = Tarea.find(params[:id])
  end

  def tarea_params
    params.require(:tarea).permit(:descripcion, :completada, :tarea_padre_id)
  end
  
   def asignar_usuarios(tarea)
    if params[:users]
      usuarios = User.where(email: params[:users])
      tarea.users = usuarios
    end
  end
  
  
end
