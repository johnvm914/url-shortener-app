class LinksController < ApplicationController

  def index
    @links = Link.where(user_id: current_user.id)
    render "index.html.erb"
  end

  def new
    @link = Link.new
    render "new.html.erb"
  end

  def create
    @link = Link.new(user_id: current_user.id, slug: params[:slug], target_url: params[:target_url])
    if @link.save
      redirect_to "/links"
    else
      render "new.html.erb"
    end
  end

  def show
    @link = Link.find_by(slug: params[:id])
    if @link
      if @link.user_id == current_user.id
        render "show.html.erb"
      else
        flash[:warning] = "This is not one of your links!"
        redirect_to "/links"
      end
    else
      flash[:warning] = "Link does not exist!"
      redirect_to "/links"
    end
  end

  def edit
    @link = Link.find_by(slug: params[:id])
    if @link.user_id == current_user.id
      render "edit.html.erb"
    else
      flash[:warning] = "This is not one of your links!"
      redirect_to "/links"
    end
  end

  def update
    @link = Link.find_by(slug: params[:id])
    @link.assign_attributes(slug: params[:slug], target_url: params[:target_url])
    if @link.save
      redirect_to "/links/#{@link.slug}"
    else
      render "edit.html.erb"
    end
  end

  def destroy
    @link = Link.find_by(slug: params[:id])
    @link.destroy
    redirect_to "/links"
  end

end
