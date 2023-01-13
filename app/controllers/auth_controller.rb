class AuthController < ApplicationController
    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: {
                message: "Success",
                data: @user,
                token: token
            }, status: 200
        else
            render json: {
                error: "Validation Failed"
            }, status: 400
        end
    end
end
