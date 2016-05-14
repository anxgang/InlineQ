class Store < ActiveRecord::Base
  validates :name, :tel, :content, presence: true
  belongs_to :user
  has_many :numbers, dependent: :destroy
  has_one :store_photo, dependent: :destroy
  accepts_nested_attributes_for :store_photo
end
