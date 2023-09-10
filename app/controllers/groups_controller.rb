class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @new_book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def join
    @group = Group.find(params[:id])
    @group.users << current_user
    redirect_to  groups_path
  end

  def leave
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def new_mail
    @group = Group.find(params[:id])
  end

  def create_mail
    @group = Group.find(params[:id])
    @group_users = @group.users
    @title = params[:title]
    @content = params[:content]
    if @title.present? && @content.present?
     #GroupMailer.send_notification(@group_users, @title, @content).deliver_now
    else
      render :new_mail
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
