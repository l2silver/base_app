FactoryGirl.define do
  factory :user do
    email "example@cvstom.org"
    password "password"
    password_confirmation "password"
	factory :activated_user do
		activated true
	end
  end
end