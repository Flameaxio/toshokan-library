module Api
  module V1
    class SearchesController < ApiController
      TYPES = %w[Books Authors Genres]

      def types
        render json: TYPES.as_json
      end
    end
  end
end
