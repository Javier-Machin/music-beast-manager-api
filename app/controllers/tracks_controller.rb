class TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]

  # GET /tracks
  def index
    @tracks = Track.all
    json_response(@tracks)
  end

  # POST /tracks
  def create
    @track = Track.create!(track_params)
    json_response(@track, :created)
  end

  # GET /tracks/:id
  def show
    json_response(@track)
  end

  # PATCH /tracks/:id
  def update
    @track.update(track_params)
    json_response(@track)
  end

  # DELETE /tracks/:id
  def destroy
    @track.destroy
    head :no_content
  end

  private

  def track_params
    # whitelist params
    params.permit(:title, :created_by, artist: [:name], file: :data)
  end

  def set_track
    @track = Track.find(params[:id])
  end
end
