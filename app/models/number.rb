class Number < ActiveRecord::Base
  belongs_to :store, counter_cache: true
  belongs_to :user
end
