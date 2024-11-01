class Tagging < ApplicationRecord
  belongs_to :dish
  belongs_to :tag
end
