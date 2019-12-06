module WithPagination
  def tracks_with_pagination
    previous_page = nil
    next_page = nil
    previous_page_track_count = 0
    next_page_track_count = 0
    begin
      previous_page_track_count = current_user.tracks.paginate(
        page: params[:page].to_i - 1,
        per_page: params[:per_page]
      ).length
    rescue
    ensure
      previous_page = params[:page].to_i - 1 if previous_page_track_count >= 1
    end
      
    begin
      next_page_track_count = current_user.tracks.paginate(
        page: params[:page].to_i + 1, 
        per_page: params[:per_page]
      ).length
    rescue
    ensure
      next_page = params[:page].to_i + 1 if next_page_track_count >= 1
    end

    tracks = current_user.tracks.paginate(page: params[:page], per_page: params[:per_page])

    {
      tracks: tracks,
      pagination: {
        prev_page: previous_page,
        next_page: next_page
      }
    }
  end
end