module Api
  module V1
    class ScoresController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :restrict_access
      before_action :cors_preflight_check
      after_action :cors_set_access_control_headers
      respond_to :json

      # For all responses in this controller, return the CORS access control headers.
      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Max-Age'] = "1728000"
      end

      # If this is a preflight OPTIONS request, then short-circuit the
      # request, return only the necessary headers and return an empty
      # text/plain.

      def cors_preflight_check
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
        headers['Access-Control-Max-Age'] = '1728000'
      end

      def index
        respond_with Score.where(:game_id => params[:game_id]).order('score desc')
      end

      def show        
        respond_with Score.find(params[:id])
      end

      def create
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