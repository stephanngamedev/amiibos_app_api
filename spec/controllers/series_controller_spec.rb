require 'rails_helper'

RSpec.describe SeriesController, :type => :controller do
	
	let(:valid_attributes){
		FactoryGirl.attributes_for( :smash_bros_series )
	}

	let(:invalid_attributes){
		{ name: "" }
	}

	describe "GET index" do
		it "find all series" do
			series = Series.create! valid_attributes
			
			expect( Series ).to receive( :all ).and_return( [ series ] )

			get :index
		end

		it "render series" do
			series = Series.create! valid_attributes
			
			expect( controller ).to receive( :render ).with( json: [ series ] )

			get :index
		end
	end

	describe "GET show" do
		it "find series with given id" do
			series = Series.create! valid_attributes
			
			expect( Series ).to receive( :find ).with( series.to_param ).and_return( series )

			get :show, params: { id: series.to_param }
		end
		
		it "render series" do
			series = Series.create! valid_attributes
			
			expect( controller ).to receive( :render ).with( json: series )

			get :show, params: { id: series.to_param }
		end
	end

	describe "POST create" do
		it "permit only whitelisted params" do
			params = { params: { series: valid_attributes } }
			
			is_expected.to permit(:name ).for(:create, params: params).on(:series)
		end

		context "with valid params" do
			it "creates a new series" do
				expect{
					post :create, params: { series: valid_attributes }
					}.to change( Series, :count ).by( 1 )
				end

				it "render saved series's json" do
					series = Series.new( valid_attributes )
					
					request_params = valid_attributes.stringify_keys.transform_values{ |v| v.to_s }
					
					allow( Series ).to receive( :new ).with( request_params ).and_return( series )

					expect( controller ).to receive( :render ).with(
						json: series,
						status: :created,
						location: series
						)

					post :create, params: { series: valid_attributes }
				end
			end

			context "with invalid params" do
				it "don't create a new series" do
					expect{
						post :create, params: { series: invalid_attributes }
						}.to_not change( Series, :count )
					end

					it "render series's errors" do
						series = Series.new( invalid_attributes )
						
						allow( Series ).to receive( :new ).with( invalid_attributes.stringify_keys ).and_return( series )

						expect( controller ).to receive( :render ).with(
							json: series.errors,
							status: :unprocessable_entity
							)

						post :create, params: { series: invalid_attributes }
					end
				end
			end

			describe "PUT update" do
				let(:new_params) {
					{ name: "Capcom" }
				}

				it "permit only whitelisted params" do
					series = Series.create! valid_attributes

					params = { params: { id: series.to_param, series: new_params } }
					
					is_expected.to permit(:name).for(:update, params: params).on(:series)
				end

				it "find series by given id" do
					series = Series.create! valid_attributes
					
					expect( Series ).to receive( :find ).with( series.to_param ).and_return( series )

					put :update, params: { id: series.to_param, series: new_params }
				end

				context "with valid params" do
					it "update series" do
						series = Series.create! valid_attributes

						request_params = new_params.stringify_keys.transform_values{ |v| v.to_s }
						
						allow( Series ).to receive( :find ).with( series.to_param ).and_return( series )
						
						expect( series ).to receive( :update ).with( request_params ).and_return( true )

						put :update, params: { id: series.to_param, series: new_params }
					end

					it "render updated series" do
						series = Series.create! valid_attributes
						
						request_params = new_params.stringify_keys.transform_values{ |v| v.to_s }
						
						allow( Series ).to receive( :find ).with( series.to_param ).and_return( series )

						expect( controller ).to receive( :render ).with( json: series )

						put :update, params: { id: series.to_param, series: new_params }
					end
				end

				context "with invalid params" do
					it "don't update series" do
						series = Series.create! valid_attributes
						
						request_params = invalid_attributes.stringify_keys.transform_values{ |v| v.to_s }
						
						allow( Series ).to receive( :find ).with( series.to_param ).and_return( series )
						
						expect( series ).to receive( :update ).with( request_params ).and_return( false )

						put :update, params: { id: series.to_param, series: invalid_attributes }
					end

					it "render series's errors" do
						series = Series.create! valid_attributes
						
						allow( Series ).to receive( :find ).with( series.to_param ).and_return( series )
						
						expect( controller ).to receive( :render ).with( 
							json: series.errors,
							status: :unprocessable_entity
							)

						put :update, params: { id: series.to_param, series: invalid_attributes }
					end
				end
			end

			describe "DELETE destroy" do
				it "find series by given id" do
					series = Series.create! valid_attributes
					
					expect( Series ).to receive( :find ).with( series.to_param ).and_return( series )

					delete :destroy, params: { id: series.to_param }
				end

				it "destroy the requested series" do
					series = Series.create! valid_attributes
					
					allow( Series ).to receive( :find ).with( series.to_param ).and_return( series )
					
					expect( series ).to receive( :destroy )

					delete :destroy, params: { id: series.to_param }
				end
			end
		end
