require 'rails_helper'

RSpec.describe CompanySerializer, :type => :serializer do
	context 'Resource representation' do
		let(:resource) { FactoryGirl.build(:nintendo, amiibos: [FactoryGirl.build(:ness)]) }

		let(:serializer) { CompanySerializer.new(resource) }
		let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }

		subject do
			JSON.parse( serialization.to_json )
		end

		[ 'id', 'name' ].each do |key| 
			it "has #{key}" do
				expect( subject[key] ).to eql( resource.send( key.to_sym ) )
			end
		end

		it "has many amiibos" do
			expect( subject['amiibos'] ).to be_present
		end
	end
end