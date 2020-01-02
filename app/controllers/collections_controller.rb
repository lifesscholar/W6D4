class CollectionsController < ApplicationController

    def index
        if params.has_key?(:user_id)
            collections = Collection.where(user_id: params[:user_id])
            render json: collections
        else
            render json: "Need to specify user"
        end
    end

    def show
        collection = Collection.find(params[:id])
        artworks = collection.artworks
        render json: artworks.to_a.map{|ele| "#{ele.title} - #{ele.image_url}"}.unshift(collection.name)
        # render json: artworks
    end

    def create
        collection = Collection.new(collect_params)
        if collection.save
            render json: collection
        else
            render json: collection.errors.full_messages, status: 422
        end
    end

    def destroy
        collection = Collection.find(params[:id])
        collection.destroy
        render json: "Destroyed #{collection.name} collection!"
    end

    private

    def collect_params
        params.require(:collection).permit(:name, :user_id)
    end

end