class Category < ApplicationRecord
  has_many :knowledges, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
