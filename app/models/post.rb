class Post < ApplicationRecord
  # Add this method to allow Ransack to search the specified attributes
  def self.ransackable_attributes(auth_object = nil)
    ["title", "content", "created_at", "updated_at", "user_id"]
  end

  # Add other model associations and validations if needed
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
