class Category < ApplicationRecord
  has_many :knowledges

  validates :name, presence: true, uniqueness: true
end
