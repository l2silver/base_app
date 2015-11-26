require 'rails_helper'

RSpec.describe User, type: :model do

	it "creates activation_digest" do
		user = User.create(email: "USer@example.org", password: "password", password_confirmation: "password")
		expect(user.authenticated?("activation", user.activation_token)).to be_truthy
	end

	it "converts valid email to lowercase" do
		user = User.create(email: "USer@example.org", password: "password", password_confirmation: "password")
		expect(user.email).to eq("user@example.org")
	end

	it "fails valid email" do
		user = User.new(email: "user@", password: "password", password_confirmation: "password")
		expect(user.save).to be_falsey
	end

	it "fails 6 digit or > password" do
		user = User.new(email: "user@example.org", password: "pass", password_confirmation: "pass")
		expect(user.save).to be_falsey
	end

	it "passes valid create" do
		user = User.new(email: "user@example.org", password: "password", password_confirmation: "password")
		expect(user.save).to be_truthy
	end

	context "existing users" do
		let(:user){create(:activated_user)}
		
		it "remembers" do
			user.remember
			expect(user.authenticated?("remember", user.remember_token)).to be_truthy
		end

		it "forgets" do
			user.forget
			expect(user.remember_digest).to be_nil
		end
	end
end
