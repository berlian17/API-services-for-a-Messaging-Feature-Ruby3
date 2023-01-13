class UserController < ApplicationController
    before_action :authorize, only: [:index]

    def index
        begin
            @user = User.all
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

    def create
        @user = User.new(user_params)
        if @user.save
            render json: {
                message: "Success",
                data: @user
            }, status: 200
        else
            render json: {
                message: "Failed"
            }, status: 400
        end
    end

    private

    def user_params
        params.permit(:name, :email, :password)
    end
end
