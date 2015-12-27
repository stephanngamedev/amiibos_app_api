require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do

	let(:valid_attributes){
		FactoryGirl.attributes_for( :nintendo )
	}

	let(:invalid_attributes){
		{ name: "" }
	}

	describe "GET index" do
		it "find all companies" do
			company = Company.create! valid_attributes
			
			expect( Company ).to receive( :all ).and_return( [ company ] )

			get :index
		end

		it "render companies" do
			company = Company.create! valid_attributes
			
			expect( controller ).to receive( :render ).with( 
				json: [ company ],
				each_serializer: CompaniesSerializer 
			)

			get :index
		end
	end

	describe "GET show" do
		it "find company with given id" do
			company = Company.create! valid_attributes
			
			expect( Company ).to receive( :find ).with( company.to_param ).and_return( company )

			get :show, params: { id: company.to_param }
		end
		
		it "render company" do
			company = Company.create! valid_attributes
			
			expect( controller ).to receive( :render ).with( json: company )

			get :show, params: { id: company.to_param }
		end
	end

	describe "POST create" do
		it "permit only whitelisted params" do
			params = { params: { company: valid_attributes } }
			
			is_expected.to permit(:name ).for(:create, params: params).on(:company)
		end

		context "with valid params" do
			it "creates a new company" do
				expect{
					post :create, params: { company: valid_attributes }
				}.to change( Company, :count ).by( 1 )
			end

			it "render saved company's json" do
				company = Company.new( valid_attributes )
				
				request_params = valid_attributes.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Company ).to receive( :new ).with( request_params ).and_return( company )

				expect( controller ).to receive( :render ).with(
					json: company,
					status: :created,
					location: company
				)

				post :create, params: { company: valid_attributes }
			end
		end

		context "with invalid params" do
			it "don't create a new company" do
				expect{
					post :create, params: { company: invalid_attributes }
				}.to_not change( Company, :count )
			end

			it "render company's errors" do
				company = Company.new( invalid_attributes )
				
				allow( Company ).to receive( :new ).with( invalid_attributes.stringify_keys ).and_return( company )

				expect( controller ).to receive( :render ).with(
					json: company.errors,
					status: :unprocessable_entity
				)

				post :create, params: { company: invalid_attributes }
			end
		end
	end

	describe "PUT update" do
		let(:new_params) {
			{ name: "Capcom" }
		}

		it "permit only whitelisted params" do
			company = Company.create! valid_attributes

			params = { params: { id: company.to_param, company: new_params } }
			
			is_expected.to permit(:name).for(:update, params: params).on(:company)
		end

		it "find company by given id" do
			company = Company.create! valid_attributes
		
			expect( Company ).to receive( :find ).with( company.to_param ).and_return( company )

			put :update, params: { id: company.to_param, company: new_params }
		end

		context "with valid params" do
			it "update company" do
				company = Company.create! valid_attributes
				
				request_params = new_params.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Company ).to receive( :find ).with( company.to_param ).and_return( company )
				
				expect( company ).to receive( :update ).with( request_params ).and_return( true )

				put :update, params: { id: company.to_param, company: new_params }
			end

			it "render updated company" do
				company = Company.create! valid_attributes
				
				request_params = new_params.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Company ).to receive( :find ).with( company.to_param ).and_return( company )

				expect( controller ).to receive( :render ).with( json: company )

				put :update, params: { id: company.to_param, company: new_params }
			end
		end

		context "with invalid params" do
			it "don't update company" do
				company = Company.create! valid_attributes
				
				request_params = invalid_attributes.stringify_keys.transform_values{ |v| v.to_s }
				
				allow( Company ).to receive( :find ).with( company.to_param ).and_return( company )
				
				expect( company ).to receive( :update ).with( request_params ).and_return( false )

				put :update, params: { id: company.to_param, company: invalid_attributes }
			end

			it "render company's errors" do
				company = Company.create! valid_attributes
				
				allow( Company ).to receive( :find ).with( company.to_param ).and_return( company )
				
				expect( controller ).to receive( :render ).with( 
					json: company.errors,
					status: :unprocessable_entity
				)

				put :update, params: { id: company.to_param, company: invalid_attributes }
			end
		end
	end

	describe "DELETE destroy" do
		it "find company by given id" do
			company = Company.create! valid_attributes
		
			expect( Company ).to receive( :find ).with( company.to_param ).and_return( company )

			delete :destroy, params: { id: company.to_param }
		end

		it "destroy the requested company" do
			company = Company.create! valid_attributes
			
			allow( Company ).to receive( :find ).with( company.to_param ).and_return( company )
			
			expect( company ).to receive( :destroy )

			delete :destroy, params: { id: company.to_param }
		end
	end
end
