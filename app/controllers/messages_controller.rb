class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = @room.id

    if @message.save
      redirect_to room_path(@room)
    else
      redirect_to room_path(@room)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
