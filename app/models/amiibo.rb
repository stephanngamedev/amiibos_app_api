class Amiibo < ApplicationRecord
	validates_presence_of :name, :release_date, :company_id, 
		:description, :detail_image_url, :boxart_image_url
	validates_uniqueness_of :name
end
