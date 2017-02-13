class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
  def show
    @kitten = Kitten.find(params[:id])
  end
  def new
    @kitten = Kitten.new
  end
  def create
    @kitten = Kitten.new(kitten_params)
    @kitten.save
    flash[:success] = "#{@kitten.name} created"
    redirect_to root_url
  end
  def edit
    @kitten = Kitten.find(params[:id])
  end
  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = "Kitty updated"
      redirect_to @kitten
    else
      render 'edit'
    end
  end
  def destroy
    Kitten.find(params[:id]).destroy
    flash[:success] = "Kitty deleted"
    redirect_to root_url
  end

  private
  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

end
