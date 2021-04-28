module Api
  module V1
    class ApiController < ApplicationController
      respond_to :json
      skip_before_action :verify_authenticity_token
    end
  end
end
