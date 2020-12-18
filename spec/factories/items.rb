FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    price { Faker::Number.within(range: 300..9_999_999) }
    explanation { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 2..11) }
    condition_id { Faker::Number.within(range: 2..7) }
    delivery_charge_id { Faker::Number.within(range: 2..11) }
    prefecture_id { Faker::Number.within(range: 2..3) }
    shipping_day_id { Faker::Number.within(range: 2..4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
