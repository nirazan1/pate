class PetsController < ApplicationController
  def new
    @pet = current_user.pets.build
  end

  def index
    @pet = Pet.new
    @pets = Pet.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pets }
    end
  end

  def create
    @pet = current_user.pets.build(pet_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @pets, notice: 'Pet was successfully added.' }
        format.js
      else
        format.html { render action: "index" }
        format.js
      end
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to pets_path }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url,notice: 'Pet was successfully removed.' }
      format.js
    end
  end

  private
  def pet_params
    params.require(:pet).permit(:title,:description)
  end
end
