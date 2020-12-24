class OrderShippingAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :block, :building, :telephone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/,
                                     message: 'Input correctly' }
    validates :prefecture_id, numericality: { other_than: 1,
                                              message: 'Select' } 
    validates :city
    validates :block
    validates :telephone_number, format: {with: /\A\d{1,11}\z/,
                                          message: 'Input only max 11 digit numbers' }
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, block: block, building: building, telephone_number: telephone_number, order_id: order.id)
  end
end