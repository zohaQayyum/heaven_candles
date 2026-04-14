class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy

  enum role: { customer: 0, admin: 1 }

  after_create :send_welcome_email

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
