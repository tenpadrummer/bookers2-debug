class RoomsController < ApplicationController
  def create
    @room = Room.create
    current_room_user = RoomUser.create(user_id: current_user.id, room_id: @room.id)
    another_room_user = RoomUser.create(user_id: params[:room_user][:user_id], room_id: @room.id)
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
    @room_users = @room.room_users
    @another_room_users = @room_users.where.not(user_id: current_user.id).first
  end
end
