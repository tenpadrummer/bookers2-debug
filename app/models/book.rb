class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :view_counts, dependent: :destroy

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
  
  # 読書記録
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)} #今週
  scope :created_last_week, -> {where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day)} #前週
end
