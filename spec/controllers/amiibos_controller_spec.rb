require 'rails_helper'

describe AmiibosController, :type => :controller do
	let(:valid_attributes){
		FactoryGirl.attributes_for( :ness )
	}

	let(:invalid_attributes){
		{ name: "" }
	}

	describe "GET index" do
		it "find all amiibos" do
			amiibo = Amiibo.create! valid_attributes
			
			expect( Amiibo ).to receive( :all ).and_return( [ amiibo ] )

			get :index
		end

		it "render amiibos" do
			amiibo = Amiibo.create! valid_attributes
			
			expect( controller ).to receive( :render ).with( json: [ amiibo ] )

			get :index
		end
	end

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

	describe "PUT update" do
		let(:new_params) {
			{ name: "New Ness" }
		}

		it "permit only whitelisted params" do
			amiibo = Amiibo.create! valid_attributes

			params = { params: { id: amiibo.to_param, amiibo: new_params } }
			
			is_expected.to permit(
				:name, 
				:series_id, 
				:release_date, 
				:company_id, 
				:description, 
				:detail_image_url, 
				:boxart_image_url)
			.for(:update, params: params)
			.on(:amiibo)
		end

		it "find amiibo by given id" do
			amiibo = Amiibo.create! valid_attributes
		
			expect( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )

			put :update, params: { id: amiibo.to_param, amiibo: new_params }
		end

		context "with valid params" do
			it "update amiibo" do
				amiibo = Amiibo.create! valid_attributes
				
				request_params = new_params.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )
				
				expect( amiibo ).to receive( :update ).with( request_params ).and_return( true )

				put :update, params: { id: amiibo.to_param, amiibo: new_params }
			end

			it "render updated amiibo" do
				amiibo = Amiibo.create! valid_attributes
				
				request_params = new_params.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )

				expect( controller ).to receive( :render ).with( json: amiibo )

				put :update, params: { id: amiibo.to_param, amiibo: new_params }
			end
		end

		context "with invalid params" do
			it "don't update amiibo" do
				amiibo = Amiibo.create! valid_attributes
				
				request_params = invalid_attributes.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )
				
				expect( amiibo ).to receive( :update ).with( request_params ).and_return( false )

				put :update, params: { id: amiibo.to_param, amiibo: invalid_attributes }
			end

			it "render amiibo's errors" do
				amiibo = Amiibo.create! valid_attributes
				
				allow( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )
				
				expect( controller ).to receive( :render ).with( 
					json: amiibo.errors,
					status: :unprocessable_entity
				)

				put :update, params: { id: amiibo.to_param, amiibo: invalid_attributes }
			end
		end
	end

	describe "DELETE destroy" do
		it "find amiibo by given id" do
			amiibo = Amiibo.create! valid_attributes
		
			expect( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )

			delete :destroy, params: { id: amiibo.to_param }
		end

		it "destroy the requested amiibo" do
			amiibo = Amiibo.create! valid_attributes
			
			allow( Amiibo ).to receive( :find ).with( amiibo.to_param ).and_return( amiibo )
			
			expect( amiibo ).to receive( :destroy )

			delete :destroy, params: { id: amiibo.to_param }
		end
	end
end
