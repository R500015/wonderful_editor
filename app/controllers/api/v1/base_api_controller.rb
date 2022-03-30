class Api::V1::BaseApiController < ApplicationController
  # skip_before_action :authenticate_api_v1_user! , only: %i[ index show ]
  include DeviseTokenAuth::Concerns::SetUserByToken
  # before_action :authenticate_api_v1_user!

  # articles = current_user.articles

end
