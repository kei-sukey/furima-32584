require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname、email、passwordとpassword_confirmation、ユーザー本名とフリガナ、生年月日が存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailが@を含まないと登録できないこと' do
      @user.email = 'hogehogehoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字以上でないと登録できないこと' do
      @user.password = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordは半角英数字混合での入力でないと登録できないこと' do
      @user.password = 'hogehoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
    end

    it 'password_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordとpassword_confirmationの値が一致しないと登録できないこと' do
      @user.password_confirmation = 'hoge12'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名名字が空では登録できないこと' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'ユーザー本名名字は、全角（漢字・ひらがな・カタカナ）でないと登録できないこと' do
      @user.last_name = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name Full-width characters')
    end

    it 'ユーザー本名名前が空では登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'ユーザー本名名前は、全角（漢字・ひらがな・カタカナ）でないと登録できないこと' do
      @user.first_name = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name Full-width characters')
    end

    it 'ユーザー本名名字フリガナが空では登録できないこと' do
      @user.last_kana_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last kana name can't be blank")
    end

    it 'ユーザー本名名前フリガナが空では登録できないこと' do
      @user.first_kana_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First kana name can't be blank")
    end

    it 'ユーザー本名名字フリガナは、全角カタカナでないと登録できないこと' do
      @user.last_kana_name = 'ほげ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last kana name Full-width katakana characters')
    end

    it 'ユーザー本名名前フリガナは、全角カタカナでないと登録できないこと' do
      @user.first_kana_name = 'ほげ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First kana name Full-width katakana characters')
    end

    it '生年月日が空では登録できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
