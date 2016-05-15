class Store < ActiveRecord::Base
  validates :name, :tel, :content, :category, presence: true

  belongs_to :user
  belongs_to :category
  has_many :numbers, dependent: :destroy
  has_one :store_photo, dependent: :destroy

  accepts_nested_attributes_for :store_photo

  # delegate :name, :to => :category, :prefix => true, :allow_nil => true
end
