class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    @relationship = Relationship.find_by(follower_id: current_user.id, followed_id: user.id)
    @relationship.destroy
    redirect_to user
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.following
    @new_book = Book.new
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    @new_book = Book.new
  end
end
