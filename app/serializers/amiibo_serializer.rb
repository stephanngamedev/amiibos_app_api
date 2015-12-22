class AmiiboSerializer < ActiveModel::Serializer
	attributes 	:id, 
				:name, 
				:series_id, 
				:release_date, 
				:company_id, 
				:description, 
				:detail_image_url, 
				:boxart_image_url
				
	#belongs_to :series_id, company_id
end
