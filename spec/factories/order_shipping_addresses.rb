FactoryBot.define do
  factory :order_shipping_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 14 }
    city { '東京都' }
    block { '1-1' }
    building { '富士見ハイツ101' }
    telephone_number { '09012345678' }
  end
end
