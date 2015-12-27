require 'rails_helper'

RSpec.describe SeriesCollectionSerializer, :type => :serializer do
	context 'Resource representation' do
		let(:resource) { FactoryGirl.build(:smash_bros_series, amiibos: [FactoryGirl.build(:ness)]) }

		let(:serializer) { SeriesCollectionSerializer.new(resource) }
		let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }

		subject do
			JSON.parse( serialization.to_json )
		end

		[ 'id', 'name' ].each do |key| 
			it "has #{key}" do
				expect( subject[key] ).to eql( resource.send( key.to_sym ) )
			end
		end

		it "has not amiibos" do
			expect( subject['amiibos'] ).to_not be_present
		end
	end
end