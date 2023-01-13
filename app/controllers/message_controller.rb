class MessageController < ApplicationController
    before_action :authorize, only: [:index, :roomChatList, :roomChatDetail, :messageNewRoom, :messageWithRoom]

    def index
        begin
            @user = User.where.not(id: user_id)
        rescue => exception
            render json: {
                message: "Failed"
            }, status: 400
        ensure
            render json: {
                message: "Success",
                data: @user
            }, status: 200
        end
    end

    def roomChatList
        begin
            @room = Room.where(:user_id => user_id).or(Room.where(to_user_id: user_id))
        rescue => exception
            render json: {
                message: "No message"
            }, status: 200
        ensure
            render json: {
                message: "Success",
                data: @room
            }, status: 400
        end
    end

    def roomChatDetail
        # Check room chat
        @room = Room.where(id: params[:id]).first

        # Get message
        @messages = Message.where(room_id: params[:id])
        @message = Message.where(room_id: params[:id]).first

        if @message.to_user_id != user_id
            # Update status message
            @messages.each do |m|
                m.update(status: "1")
            end
        end

        render json: {
            message: "Success",
            data: @messages
        }, status: 200
    end

    def messageNewRoom
        # Check room chat
        @room = Room.where(:user_id => user_id).where(to_user_id: params[:to_user_id])

        # Get receiver data
        @receiver = User.where(id: params[:to_user_id]).first

        #  Prevent sending to itself
        if user_id != @receiver.id
            # Check message
            if params[:message].empty?
                render json: {
                    message: "No message input"
                }, status: 200
            else
                # Check room chat
                if @room.empty?
                    # Create new room
                    @createRoom = Room.create(user_id: user_id, to_user_id: params[:to_user_id], last_message: params[:message])
                end

                # Create new message
                @message = Message.create(room_id: @createRoom.id, user_id: user_id, to_user_id: params[:to_user_id], message: params[:message], status: "0")
                render json: {
                    message: "Message sent successfully",
                    data: @message,
                    receiver: @receiver
                }, status: 200
            end
        else
            render json: {
                message: "Unable to send message to self",
            }, status: 200
        end
    end

    def messageWithRoom
        # Get room data
        @room = Room.where(id: params[:id]).first

        # Get receiver data
        @receiver = User.where(id: params[:to_user_id]).first

        # Check message
        if params[:message].empty?
            render json: {
                message: "No message input"
            }, status: 200
        else
            # Create new message
            @message = Message.create(room_id: params[:id], user_id: user_id, to_user_id: params[:to_user_id], message: params[:message], status: "0")

            # Update last message
            @room.update(last_message: params[:message])
            render json: {
                message: "Message sent successfully",
                data: @message,
                receiver: @receiver
            }, status: 200
        end
    end

    private

    def user_id
        decoded_token = decode_token()
        if decoded_token
            user_id = decoded_token[0]['user_id']
        end
    end
end
