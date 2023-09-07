class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence:true
  validates :body,  presence:true, length:{maximum:200}

  # 投稿の検索
  def self.search(keyword, match_label)
    case match_label
    when "1"
      search_params = "#{keyword}%"
    when "2"
      search_params ="%#{keyword}"
    when "3"
      search_params = "#{keyword}"
    when "4"
      search_params = "%#{keyword}%"
    end

    if keyword.present?
      Book.where("title LIKE?","#{search_params}")
    else
      Book.all
    end
  end
end
