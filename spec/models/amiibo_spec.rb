require 'rails_helper'

RSpec.describe Amiibo, :type => :model do
	[ 	:name, 
		:series_id, 
		:release_date, 
		:company_id, 
		:description, 
		:detail_image_url, 
		:boxart_image_url 
	].each do |column|
		it { is_expected.to  have_db_column( column ) }
	end

	[ 	:name, 
		:release_date, 
		:company_id, 
		:description, 
		:detail_image_url, 
		:boxart_image_url 
	].each do |attribute|
		it { is_expected.to validate_presence_of(attribute) }
	end

	it { is_expected.to validate_uniqueness_of( :name ) }
end
