require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do

	let(:email){"example_1@cvstom.org"}
	let(:user){User.create(email: email,
						activated: false,
						password: "password",
						password_confirmation: "password")
				}

	
	before{ allow(User).to receive(:find_by) { user } }
	
	describe "successfully activates user " do
	
		it "loads template" do
			get :edit, {id: user.activation_token, email: email}
		    expect(response).to render_template("static_pages/logged_in")
		end
		it "logs user in" do
			get :edit, {id: user.activation_token, email: email}
		    expect(session[:user_id]).to eq(user.id)
		end

		it "updates user to activated" do
			get :edit, {id: user.activation_token, email: email}
		    expect(user.activated).to be_truthy
		end
		it "creates flash" do
			flash[:error] = "error"
			get :edit, {id: user.activation_token, email: email}
		    expect(flash.empty?).to be_truthy
		end

	end

	describe "fails to activate user " do
	
		it "loads template" do
			get :edit, {id: user.activation_token + "1", email: email}
		    expect(response).to render_template("static_pages/logged_out")
		end
		it "creates flash" do
			get :edit, {id: user.activation_token + "1", email: email}
		    expect(flash[:warning]).to eq("There was an error activating your account")
		end
	end

end
