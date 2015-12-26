class AmiibosController < ApplicationController
	def index
		amiibos = Amiibo.all

		render json: amiibos
	end

	def show
		amiibo = Amiibo.find(params[:id])
		render json: amiibo
	end

	def create
		amiibo = Amiibo.new( amiibo_params )

		if amiibo.save
			render json: amiibo, status: :created, location: amiibo
		else
			render json: amiibo.errors, status: :unprocessable_entity
		end
	end

	def update
		amiibo = Amiibo.find( params[:id] )

		if amiibo.update( amiibo_params )
			render json: amiibo
		else
			render json: amiibo.errors, status: :unprocessable_entity
		end
	end

	def destroy
		amiibo = Amiibo.find( params[:id] )
		amiibo.destroy
	end

	private
	def amiibo_params
		params.require(:amiibo).permit( 
			:name, 
			:series_id, 
			:release_date, 
			:company_id, 
			:description, 
			:detail_image_url, 
			:boxart_image_url
		)
	end
end
