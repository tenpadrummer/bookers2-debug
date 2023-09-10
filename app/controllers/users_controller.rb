class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
    @current_room_users = RoomUser.where(user_id: current_user.id)
    @another_room_users = RoomUser.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_room_users.each do |current_room_user|
        @another_room_users.each do |another_room_user|
          if current_room_user.room_id == another_room_user.room_id
            @is_room = true
            @room_id = current_room_user.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @room_user = RoomUser.new
      end
    end
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    @users = User.all
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
