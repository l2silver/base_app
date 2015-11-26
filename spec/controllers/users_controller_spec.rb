require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "create user" do
		it "successfully creates user" do
		  post :create, {:email => "l2silver@ryerson.ca", :password => "password"}
		  expect(flash[:success]).to eq("Account successfully created. Please check your email for the confirmation link to continue")
		end

		it "sends out account activation email" do
		    expect { post :create, {:email => "l2silver@ryerson.ca", :password => "password"} }.to change { ActionMailer::Base.deliveries.count }.by(1)
		end
	end


	describe "check user email" do
		it "successfully checks users email" do
			User.create(email: "example_1@cvstom.org", password: "password", password_confirmation: "password")
			get :check_email, {:email => "examplE_1@cvstom.org"}, :format => :json
			expect(response.body).to eq(JSON.generate({response: true}))
		end
	end
end
