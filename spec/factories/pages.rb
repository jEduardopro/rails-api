FactoryBot.define do 
	factory :page do
		title { Faker::Lorem.sentence }
	end
end
