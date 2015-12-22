require 'rails_helper'

describe AmiibosController, type: :routing do
	describe 'routing' do
		it "routes to #show" do
			expect( get: "/amiibos/1" ).to route_to("amiibos#show", id: "1")
		end

		it "routes to #create" do
			expect( post: "/amiibos" ).to route_to("amiibos#create")
		end
	end
end