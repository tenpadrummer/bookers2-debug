class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # class_nameで1つのモデルに対して、二つのアソシエーションを組む。
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

  has_many :messages, dependent: :destroy

  has_many :view_counts, dependent: :destroy

  has_many :groups,through: :group_users
  has_many :group_users

  has_one_attached :profile_image

  validates :name,         length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # フォローするメソッド
  def follow(other_user)
    following << other_user
  end

  # アンフォローのメソッド
  def unfollow(other_user)
    following.delete(other_user)
  end

  #フォローしているか調べるメソッド
  def following?(other_user)
    following.include?(other_user)
  end

  # ユーザーの検索
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
      User.where("name LIKE?","#{search_params}")
    else
      User.all
    end
  end
end
