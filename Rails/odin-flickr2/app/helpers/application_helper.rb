module ApplicationHelper
  def make_flickr_url(r, size = 't')
    "http://farm#{r.farm}.static.flickr.com/" << "#{r.server}/#{r.id}_#{r.secret}_#{size}.jpg"
  end
end
