class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :password,        format: { with: PASSWORD_REGEX,
                                        message: 'Include both letters and numbers' }
  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/,
                                    message: 'Full-width characters' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/,
                                     message: 'Full-width characters' }
    validates :last_kana_name, format: { with: /\A[ァ-ヶー－]+\z/,
                                         message: 'Full-width katakana characters' }
    validates :first_kana_name, format: { with: /\A[ァ-ヶー－]+\z/,
                                          message: 'Full-width katakana characters' }
    validates :birthday
  end
end
