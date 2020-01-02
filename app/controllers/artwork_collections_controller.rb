class ArtworkCollectionsController < ApplicationController
    def create
        artwork_collection = ArtworkCollection.new(artwork_col_params)
        if artwork_collection.save
            render json: artwork_collection
        else
            render json: artwork_collection.errors.full_messages, status: 422
        end
    end

    def destroy
        artwork_collection = ArtworkCollection.find(params[:id])
        artwork_collection.destroy
        render json: artwork_collection
    end

    private

    def artwork_col_params
        params.require(:artwork_collection).permit(:collection_id, :artwork_id)
    end
end