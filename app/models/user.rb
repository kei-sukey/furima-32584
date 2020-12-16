class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :nickname,        presence: true
  validates :password,        format: { with: PASSWORD_REGEX,
                                        message: 'Include both letters and numbers' }
  validates :last_name,       presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/,
                                                        message: 'Full-width characters' }
  validates :first_name,      presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/,
                                                        message: 'Full-width characters' }
  validates :last_kana_name,  presence: true, format: { with: /\A[ァ-ヶー－]+\z/,
                                                        message: 'Full-width katakana characters' }
  validates :first_kana_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/,
                                                        message: 'Full-width katakana characters' }
  validates :birthday,        presence: true
end
