class TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]

  # GET /tracks
  def index
    @tracks = tracks_with_pagination
    json_response(@tracks, nil, 'index')
  end

  # POST /tracks
  def create
    @track = current_user.tracks.create!(track_params)
    json_response(@track, :created)
  end

  # GET /tracks/:id
  def show
    json_response(@track, nil, params[:serializer])
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
    params.permit(:title, :lyrics, :file, :serializer, artist: [:name])
  end

  def set_track
    @track = Track.find(params[:id])
  end
end
