FactoryGirl.define do
	factory :user do
		name "Bob Jackson"
		email "bob@jump.com"
		password "foobar"
		password_confirmation "foobar"
	end
end