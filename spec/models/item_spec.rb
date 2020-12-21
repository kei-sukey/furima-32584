require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
  end

  describe '#create' do
    context '商品出品ができる場合' do
      it '必要な情報を適切に入力すると商品出品できること' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it '画像が空だと商品出品ができないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空欄では商品出品ができないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空欄では商品出品ができないこと' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'カテゴリー情報がないと商品出品ができないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'カテゴリー情報が「---」だと商品出品ができないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品状態の情報がないと商品出品ができないこと' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '商品状態の情報が「---」だと商品出品ができないこと' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition Select')
      end

      it '配送料の負担についての情報がないと商品出品ができないこと' do
        @item.delivery_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end

      it '配送料の負担についての情報が「---」だと商品出品ができないこと' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge Select')
      end

      it '発送元の地域についての情報がないと商品出品ができないこと' do
        @item.prefecture = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域についての情報が「---」だと商品出品ができないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end

      it '発送までの日数についての情報がないと商品出品ができないこと' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it '発送までの日数についての情報が「---」だと商品出品ができないこと' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day Select')
      end

      it '販売価格が空欄だと商品出品ができないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が300円未満だと商品出品ができないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '販売価格が9,999,999円を超えると商品出品ができないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '販売価格が半角数字でないと商品出品ができないこと' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
    end
  end
end
