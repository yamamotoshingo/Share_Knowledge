class Knowledge < ApplicationRecord
  enum classification: { trivia: 0, experience: 1}

  has_one_attached :image
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :classification, presence: true
  validates :category_id, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def avg_rate
    unless self.comments.empty?
      comments.average(:rate).round(1).to_f
    else
      0.0
    end
  end

  def avg_rate_percentage
    unless self.comments.empty?
      comments.average(:rate).round(1).to_f*100/5
    else
     0.0
    end
  end
end
