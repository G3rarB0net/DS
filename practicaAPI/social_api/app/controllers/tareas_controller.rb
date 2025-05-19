class TareasController < ApplicationController
  
 def index
    if params[:usuario].present?
      @tareas = Tarea.where(usuario: params[:usuario])
    else
      @tareas = Tarea.all
    end
    
    render json: @tareas
  end

  
  def show
    render json: @tarea.as_json
  end

  
  def create
    @tarea = Tarea.new(tarea_params)
    if @tarea.save
      render json: @tarea, status: :created
    else
      render json: @tarea.errors, status: :unprocessable_entity
    end
  end

 
  def update
    if @tarea.update(tarea_params)
      render json: @tarea
    else
      render json: @tarea.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tarea.destroy
    head :no_content
  end

  private

  def set_tarea
    @tarea = Tarea.find(params[:id])
  end

  def tarea_params
    params.require(:tarea).permit(:descripcion, :completada, :usuario, :tarea_padre_id)
  end
end
