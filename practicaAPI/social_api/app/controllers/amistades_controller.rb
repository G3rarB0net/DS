class AmistadesController < ApplicationController
# GET /amistades
    def index
        if params[:usuario].present?
            @amistades = Amistad.where(usuario: params[:usuario])
        else
            @amistades = Amistad.all
        end
        render json: @amistades
    end
    
    # GET /amistades/1
    def show
        render json: @amistad
    end
    
    # POST /amistades
    def create
        @amistad = Amistad.new(amistad_params)
    
        if @amistad.save
            render json: @amistad, status: :created
        else
            render json: @amistad.errors, status: :unprocessable_entity
        end
    end
    
    # PATCH/PUT /amistades/1
    def update
        if @amistad.update(amistad_params)
            render json: @amistad
        else
            render json: @amistad.errors, status: :unprocessable_entity
        end
    end
    
    # DELETE /amistades/1
    def destroy
        @amistad = Amistad.find_by(id: params[:id])
    
        if @amistad
            @amistad.destroy
            head :no_content # Devuelve 204 sin contenido
        else
            render json: { error: "Amistad no encontrada con id #{params[:id]}" }, status: :not_found
        end
    end  

    private

    def amistad_params
        params.require(:amistad).permit(:usuario, :amistadCon)
    end
end
    
    