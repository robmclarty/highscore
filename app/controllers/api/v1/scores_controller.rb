module Api
  module V1
    class ScoresController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :restrict_access
      respond_to :json

      def index
        # @game = Game.find(params[:game_id])
        
        # respond_with @game.scores.order('score desc')

        respond_with Score.where(:game_id => params[:score][:game_id]).order('score desc')
      end

      def show
        #@game = Game.find(params[:game_id])
        
        respond_with Score.find(params[:id])
      end

      def create
        #@game = Game.find(params[:game_id])
        #params[:score][:game_id] = params[:game_id]
        score = Score.new(score_params)
        score.game_id = params[:score][:game_id]

        if score.save
          render json: score, status: :created, location: "/api/scores/#{ score.id }"
        else
          render json: score.errors, status: :unprocessable_entity
        end
      end

      private

      # Never trust parameters from the scary internet, only allow the white list through.
      def score_params
        params.require(:score).permit(:name, :score, :game_id)
      end

      def restrict_access
        game = Game.find(params[:score][:game_id])
        api_key = ApiKey.find_by_access_token(params[:score][:api_key])
        valid_api_key = api_key.user_id == game.user.id
        head :unauthorized unless api_key && valid_api_key
      end

    end
  end
end