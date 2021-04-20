class Api::V1::UsersController < ApplicationController
    before_action :find_user, only:[:show,:update,:destroy]

    #get /users
    def index
        @users=User.all
        render json:@users
    end
    #get /users/:id
    def show
        @user=find_user
        render json:@user
    end

    #post /users
    def create
        @user=User.new(user_params)
        if @user.save
            render json:@user
        else
            render json:{error:"unable to create user "}, status:400
        end
    end

    #post /users/:id
    def update
        @user=find_user
        if @user
            @user.update(user_params)
            render json:{error:"user updated"},status:200
        else
            render json:{error:"unable to update user "}, status:400
        end
    end

    def destroy
        @user=find_user
        if @user
            @user.destroy
            render json:{error:"user deleted"},status:200
        else
            render json:{error:"unable to delete user "}, status:400
        end
    end

    def find_user
        User.find(params[:id])
    end

    private
    def user_params
        params.required(:user).permit(:username,:password)
    end
end
