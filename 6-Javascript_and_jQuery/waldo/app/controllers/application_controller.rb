class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :js, :html, :xml

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with(*args, options, &blk)
  end
end
