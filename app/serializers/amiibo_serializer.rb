class AmiiboSerializer < ActiveModel::Serializer
	attributes 	:id, 
				:name, 
				:series_id, 
				:company_id,
				:release_date, 
				:description, 
				:detail_image_url, 
				:boxart_image_url
				
	belongs_to :company
	belongs_to :series
end
