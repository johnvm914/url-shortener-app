class VisitsController < ApplicationController
  
  def create
    @link = Link.find_by(slug: params[:id])
    if @link
      Visit.create(link_id: @link.id, ip_address: request.remote_ip)
      redirect_to "#{@link.target_url}"
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

end
