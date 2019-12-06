module WithPagination
  def tracks_with_pagination(page = 1, per_page = 10)
    previous_page = nil
    next_page = nil

    begin
      previous_page = current_user.tracks.paginate(
        page: params[:page].to_i - 1,
        per_page: params[:per_page]
        ).length
    rescue
    end
      
    begin
      next_page = current_user.tracks.paginate(
        page: params[:page].to_i + 1, 
        per_page: params[:per_page]
      ).length
    rescue
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