class AffiliationsController < ApplicationController
    def index
      @locations = Affiliation.all
      render json: @locations
    end
  end