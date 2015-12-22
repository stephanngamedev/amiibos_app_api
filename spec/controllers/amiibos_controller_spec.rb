require 'rails_helper'

describe AmiibosController, :type => :controller do
	let(:valid_attributes){
		FactoryGirl.attributes_for( :ness )
	}

	let(:invalid_attributes){
		{ name: "" }
	}

	describe "GET show" do
		it "find amiibo with given id" do
			amiibo = Amiibo.create! valid_attributes
			
			expect( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )

			get :show, params: { id: amiibo.to_param }
		end
		
		it "render amiibo" do
			amiibo = Amiibo.create! valid_attributes
			
			expect( controller ).to receive( :render ).with( json: amiibo )

			get :show, params: { id: amiibo.to_param }
		end
	end

	describe "POST create" do
		it "permit only whitelisted params" do
			params = { params: { amiibo: valid_attributes } }
			
			is_expected.to permit(
				:name, 
				:series_id, 
				:release_date, 
				:company_id, 
				:description, 
				:detail_image_url, 
				:boxart_image_url)
			.for(:create, params: params)
			.on(:amiibo)
		end

		context "with valid params" do
			it "creates a new amiibo" do
				expect{
					post :create, params: { amiibo: valid_attributes }
				}.to change( Amiibo, :count ).by( 1 )
			end

			it "render saved amiibo's json" do
				amiibo = Amiibo.new( valid_attributes )
				
				request_params = valid_attributes.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Amiibo ).to receive( :new ).with( request_params ).and_return( amiibo )

				expect( controller ).to receive( :render ).with(
					json: amiibo,
					status: :created,
					location: amiibo
				)

				post :create, params: { amiibo: valid_attributes }
			end
		end

		context "with invalid params" do
			it "don't create a new amiibo" do
				expect{
					post :create, params: { amiibo: invalid_attributes }
				}.to_not change( Amiibo, :count )
			end

			it "render amiibo's errors" do
				amiibo = Amiibo.new( invalid_attributes )
				
				allow( Amiibo ).to receive( :new ).with( invalid_attributes.stringify_keys ).and_return( amiibo )

				expect( controller ).to receive( :render ).with(
					json: amiibo.errors,
					status: :unprocessable_entity
				)

				post :create, params: { amiibo: invalid_attributes }
			end
		end
	end
end
