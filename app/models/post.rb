class My_Validator < ActiveRecord::Validator
  def validate(record)
    if record.title
      words = ["Top [number]", "Guess", "Won't Believe", "Secret"]
      unless words.any? {|w| record.title.include?(w)}
        record.errors[:base] << (options[:message] || "title is not clickbaity")
      end
    end
    false
  end
end

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validates_with My_Validator
end
