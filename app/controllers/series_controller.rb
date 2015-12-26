class SeriesController < ApplicationController
	def index
		series = Series.all

		render json: series
	end

	def show
		series = Series.find(params[:id])
		render json: series
	end

	def create
		series = Series.new( series_params )

		if series.save
			render json: series, status: :created, location: series
		else
			render json: series.errors, status: :unprocessable_entity
		end
	end

	def update
		series = Series.find( params[:id] )

		if series.update( series_params )
			render json: series
		else
			render json: series.errors, status: :unprocessable_entity
		end
	end

	def destroy
		series = Series.find( params[:id] )
		series.destroy
	end

	private
	def series_params
		params.require(:series).permit( :name )
	end
end
