class Category < ActiveRecord::Base
  has_many :stores, dependent: :destroy
end
