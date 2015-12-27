require 'rails_helper'

RSpec.describe AmiiboSerializer, :type => :serializer do
	context 'Resource representation' do
		let(:resource) { FactoryGirl.build(:ness) }

		let(:serializer) { AmiiboSerializer.new(resource) }
		let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }

		subject do
			JSON.parse( serialization.to_json )
		end

		[ 
			'id', 
			'name', 
			'series_id', 
			'company_id', 
			'release_date', 
			'description', 
			'detail_image_url',
			'boxart_image_url'			
		].each do |key| 
			it "has #{key}" do
				expect( subject[key] ).to eql( resource.send( key.to_sym ) )
			end
		end

		it "belongs to company" do
			expect( subject['company'] ).to be_present
		end

		it "belongs to series" do
			expect( subject['series'] ).to be_present
		end
	end
end