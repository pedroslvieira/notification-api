class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  acts_as_token_authenticatable
  has_many :user_notifications
  has_many :notifications, through: :user_notifications, dependent: :destroy
end
