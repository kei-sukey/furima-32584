FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password = Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3)
    password { password }
    password_confirmation { password }
    last_name { '試験' }
    first_name { '試験' }
    last_kana_name { 'テスト' }
    first_kana_name { 'テスト' }
    birthday { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end
