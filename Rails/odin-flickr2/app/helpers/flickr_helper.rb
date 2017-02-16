module FlickrHelper
  def user_photos(user_id, photo_count = 12)

    FlickRaw.api_key = ENV['API_KEY']
    FlickRaw.shared_secret = ENV['SHARED_SECRET']

    flickr = FlickRaw::Flickr.new

    return flickr.photos.search(:user_id => user_id, :photo_count => photo_count)

  end

  def render_flickr_sidebar_widget(user_id, photo_count = 12, columns = 2)
    begin
      photos = user_photos(user_id, photo_count).to_a.in_groups_of(2)
      render :partial => '/flickr/sidebar_widget', :locals => { :photos => photos }
    rescue Exception
      render :partial => '/flickr/unavailable'
    end
  end
end
