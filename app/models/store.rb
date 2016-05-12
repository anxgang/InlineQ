class Store < ActiveRecord::Base
  validates :name, :tel, :content, presence: true
  belongs_to :user
  has_many :numbers, dependent: :destroy
end
