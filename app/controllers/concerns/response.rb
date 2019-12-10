module Response
  def json_response(object, status = :ok, serializer = '')
    if (serializer == 'index') 
      object[:tracks] = object[:tracks].map do |track| 
        {
          id: track.id,
          title: track.title,
          artist: track.artist,
          created_by: track.created_by
        }
      end
    end

    if (serializer == 'lyrics')
      filtered_track = {
        lyrics: object.lyrics,
        title: object.title,
        artist: object.artist
      }
      
      object = filtered_track
    end

    render json: object, status: status
  end
end