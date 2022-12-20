class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  validates :nickname, presence: true
  validates :password_confirmation, presence: true, confirmation: true
  validates_confirmation_of :password_confirmation

  has_many :knowledges
  has_many :comments, dependent: :destroy

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
      profile_image
  end

  def self.user_guest
    find_or_create_by!(email: 'user_guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ユーザーゲスト"
    end
  end

  def self.admin_guest
    find_or_create_by!(email: 'admin_guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "管理者ゲスト"
      user.admin = true
    end
  end
end
