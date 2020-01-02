class UsersController < ApplicationController

    def index
        # if params.has_key?("username")
        #     users = User.find_by username: params[:username]
       
        if params[:query]
            users = User.where('username LIKE ?', "%#{params[:query]}%")
        else
            users = User.all
        end
        render json: users
    end

    def show
        user = user_find
        render json: user
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        user = user_find

        if user.update(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end

    end

    def destroy
        user = user_find
        user.destroy
        render json: "Successfully destroyed #{user.username}"
    end

    def favorites
        favorites = user_find.favorites
        render json: favorites
    end

    private

    def user_find
        User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username)
    end

end