require 'rails_helper'

describe AmiibosController, type: :routing do
	describe 'routing' do
		it "routes to #index" do
			expect( get: "/amiibos" ).to route_to("amiibos#index")
		end

		it "routes to #show" do
			expect( get: "/amiibos/1" ).to route_to("amiibos#show", id: "1")
		end

		it "routes to #create" do
			expect( post: "/amiibos" ).to route_to("amiibos#create")
		end

		it "routes to #update" do
			expect( put: "/amiibos/1" ).to route_to("amiibos#update", id: "1")
		end
	end
end