class AmiibosController < ApplicationController
	def show
		@amiibo = Amiibo.find(params[:id])
		render json: @amiibo
	end

	def create
		@amiibo = Amiibo.new( amiibo_params )

		if @amiibo.save
			render json: @amiibo, status: :created, location: @amiibo
		else
			render json: @amiibo.errors, status: :unprocessable_entity
		end
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
