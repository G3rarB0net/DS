class AsignacionTareasController < ApplicationController
  before_action :set_tarea
  before_action :set_usuario
  
  
  def create
    if @tarea.usuarios.include?(@usuario)
      render json: { mensaje: "El usuario ya está asignado a esta tarea" }, status: :ok
    else
      @tarea.usuarios << @usuario
      render json: { mensaje: "Usuario asignado correctamente" }, status: :created
    end
  end

  # DELETE /tareas/:tarea_id/usuarios/:usuario_id
  def destroy
    if @tarea.usuarios.include?(@usuario)
      @tarea.usuarios.delete(@usuario)
      render json: { mensaje: "Usuario desasignado correctamente" }, status: :ok
    else
      render json: { mensaje: "El usuario no está asignado a esta tarea" }, status: :not_found
    end
  end

  private

  def set_tarea
    @tarea = Tarea.find(params[:tarea_id])
  end

  def set_usuario
    @usuario = User.find(params[:user_id])
  end
end
