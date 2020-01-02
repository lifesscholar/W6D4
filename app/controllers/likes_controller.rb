class LikesController < ApplicationController

    def index
        # debugger
        if params.has_key?(:user_id)
            likes = Like.where(user_id: params[:user_id])
        elsif params.has_key?(:artwork_id)
            likes = Like.where(likable_id: params[:artwork_id], likable_type: "Artwork")
        elsif params.has_key?(:comment_id)
            likes = Like.where(likable_id: params[:comment_id], likable_type: "Comment")
        else
            likes = "You can't see all the likes"
        end
        render json: likes
    end

    def create
        like = Like.new(like_params)

        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: 422
        end

    end

    def destroy
        like = Like.find(params[:id])
        like.destroy
        render json: like
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :likable_type, :likable_id)
    end

end