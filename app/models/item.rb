class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :user_id
    validates :image
    with_options numericality: { other_than: 1,
                                 message: 'Select' } do
      validates :category_id
      validates :condition_id
      validates :delivery_charge_id
      validates :prefecture_id
      validates :shipping_day_id
    end
    validates :price, numericality: { only_integer: true,
                                      message: 'Half-width number' }
  end
  validates :price, numericality: { greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999,
                                    message: 'Out of setting range' }
end
