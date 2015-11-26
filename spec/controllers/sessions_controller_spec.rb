require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	
	let(:user){create(:activated_user)}

	context "successful login" do
		it "goes to correct template" do
			get :create, {session: {email: user.email, password: "password"}}
		    expect(response).to render_template("static_pages/logged_in")
		end

		it "remembers user if remember parameter" do
			get :create, {session: {email: user.email, password: "password", remember: 1}}
		    expect(cookies.signed[:user_id]).to eq(user.id)
		end

		it "clears flash" do
			flash[:alert] = "hello"
			get :create, {session: {email: user.email, password: "password"}}
			expect(flash.instance_variable_get(:@flashes)).to eq({})
		end
	end

	context "failed login" do
		it "cannot find email" do
			get :create, {session: {email: "", password: "password"}}
		    expect(response).to render_template("static_pages/logged_out")
		   	expect(flash["warning"]).to include("Email")
		end

		it "wrong password for email" do
			get :create, {session: {email: user.email, passworsd: "password"}}
		    expect(response).to render_template("static_pages/logged_out")
			expect(flash["warning"]).to include("password")
		end
	end

	context "logout" do
		it "deletes cookies" do
			delete :destroy, nil, user_id: user.id
		    expect(cookies.signed[:user_id]).to be_nil
		end

		it "deletes session" do
			delete :destroy, nil, user_id: user.id
		    expect(session[:user_id]).to be_nil
		end
		
		it "renders logged out template" do
			delete :destroy, nil, user_id: user.id
		    expect(response).to render_template("static_pages/logged_out")
		end

	end
end
