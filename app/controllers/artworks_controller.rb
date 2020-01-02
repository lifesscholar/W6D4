require "byebug"
class ArtworksController < ApplicationController

    def index
        # debugger
        # artworks = Artwork.all
        if params.has_key?(:user_id)
            artworks = Artwork.where(artist_id: params[:user_id])
            artwork_shares = User.find(params[:user_id]).shared_artworks
        end
        render json: artwork_shares + artworks

    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: 422
        end
    end

    def update
        artwork = Artwork.find(params[:id])
        if artwork.update(artwork_params)
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: 422
        end
    end

    def destroy
        artwork = Artwork.find(params[:id])
        artwork.destroy
        render json: "Successfully destroyed #{artwork.title}"
    end

    def favorite
        artwork = Artwork.find(params[:id])
        artwork.favorite = true
        artwork.save!
        render json: artwork
    end

    def unfavorite
        artwork = Artwork.find(params[:id])
        artwork.favorite = false
        artwork.save!
        render json: artwork
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end

end