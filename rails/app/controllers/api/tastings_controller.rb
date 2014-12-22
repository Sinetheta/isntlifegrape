class Api::TastingsController < ApplicationController
  before_action :find_tasting, only: [:show]

  def index
    render json: Tasting.all
  end

  def show
    render json: @tasting
  end

  private

  def find_tasting
    @tasting = Tasting.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { error: 'Tasting does not exist' }, status: :not_found
  end
end
