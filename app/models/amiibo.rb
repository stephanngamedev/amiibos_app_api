class Amiibo < ApplicationRecord
	belongs_to :company
	belongs_to :series, optional: true
	
	validates_presence_of :name, :release_date, :company_id,  :description, :detail_image_url, :boxart_image_url
	validates :name , uniqueness: { scope: :series_id }
end
