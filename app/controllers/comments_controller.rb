class CommentsController < ApplicationController

    def index
        if params.has_key?(:user_id)
            comments = Comment.where(user_id: params[:user_id])
        elsif params.has_key?(:artwork_id)
            comments = Comment.where(artwork_id: params[:artwork_id])
        else
            comments = "You can't see all the comments"
        end
        render json: comments
    end

    def create
        comment = Comment.new(comment_params)

        if comment.save
            render json: comment, status: :created
        else
            render json: comment.errors.full_messages, status: 422
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: "#{comment.body} was DESTROYED!"
    end



    private

    def comment_params
        params.require(:comment).permit(:body, :user_id, :artwork_id)
    end

end