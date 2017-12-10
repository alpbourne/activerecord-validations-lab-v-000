class My_Validator < ActiveModel::Validator
  def validate(record)
    words = ["Top [number]", "Guess", "Won't Believe", "Secret"]
    if words.none? {|w| record.title.include?(w)}
      record.errors[:title] << 'title is not clickbaity'
    end
  end
end

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validates_with My_Validator
end
