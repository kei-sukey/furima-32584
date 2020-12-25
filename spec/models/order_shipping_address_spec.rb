require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: 1, item_id: 1)
  end

  describe '#create' do
    context '商品購入ができる場合' do
      it '全ての値を適切に入力すれば商品購入ができること' do
        expect(@order_shipping_address).to be_valid
      end

      it '建物名は空でも商品購入ができること' do
        @order_shipping_address.building = nil
        expect(@order_shipping_address).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it "tokenが空では登録できないこと" do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it "郵便番号が空では登録できないこと" do
        @order_shipping_address.postal_code = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it "郵便番号にハイフンが含まれていないと登録できないこと" do
        @order_shipping_address.postal_code = "1234567"
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code Input correctly")
      end

      it "郵便番号は全てハイフンを含む半角数字でないと登録できないこと" do
        @order_shipping_address.postal_code = "abc-4567"
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code Input correctly")
      end

      it "郵便番号は全角数字だと登録できないこと" do
        @order_shipping_address.postal_code = "１２３-４５６７"
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code Input correctly")
      end

      it "都道府県情報が空では登録できないこと" do
        @order_shipping_address.prefecture_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "都道府県の選択が「---」では登録できないこと" do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture Select")
      end

      it "市区町村が空では登録できないこと" do
        @order_shipping_address.city = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it "番地が空では登録できないこと" do
        @order_shipping_address.block = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Block can't be blank")
      end

      it "電話番号が空では登録できないこと" do
        @order_shipping_address.telephone_number = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end

      it "電話番号にハイフンが含まれていると登録できないこと" do
        @order_shipping_address.telephone_number = "090-1234-5678"
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Telephone number Input only max 11 digit numbers")
      end

      it "電話番号は英数混合では登録できないこと" do
        @order_shipping_address.telephone_number = "090abcd5678"
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Telephone number Input only max 11 digit numbers")
      end

      it "電話番号は11桁以内でないと登録できないこと" do
        @order_shipping_address.telephone_number = "090123456789"
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Telephone number Input only max 11 digit numbers")
      end
    end
  end
end
