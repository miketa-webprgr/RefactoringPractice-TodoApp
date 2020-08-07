class Todo < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 30 }
end
