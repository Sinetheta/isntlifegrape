class Tasting < ActiveRecord::Base
  validates :title, presence: true
end
