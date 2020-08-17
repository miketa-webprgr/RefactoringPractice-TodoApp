class User < ApplicationRecord
  has_secure_password
  has_many :todos
  has_many :categories

  has_many :viewers, class_name: "User",
                    foreign_key: "editor_id"
  belongs_to :editor, class_name: "User", optional: true

  validates :email, presence: true, uniqueness: true,
                    length: { maximum: 255 }
  validates :name, presence: true, 
                    length: { maximum: 50 }

end
