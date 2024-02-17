class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end

  def index
    @directors = Director.order(created_at: :desc)
  end

  def show
    @director = Director.find(params[:id])
  end

  def create
    director_attributes = params.require(:director).permit(:name, :bio, :dob,)
    @director = Director.new(director_attributes)

    if @director.valid?
      @director.save
      redirect_to directors_url, notice: "Director created successfully"
    else
      render "new"
    end
  end

  def edit
    @director = Director.find(params[:id])
  end

  def update
    director_attributes = params.require(:director).permit(:name, :dob, :bio)
    director = Director.find(params[:id])
    director.name = director_attributes[:name]
    director.dob = director_attributes[:dob]
    director.bio = director_attributes[:bio]

    if director.valid?
      director.save
      redirect_to director_url(director), notice: "Director updated successfully"
    else
      redirect_to director_url(director), alert: "Director failed to update successfully"
    end
  end

  def destroy
    director = Director.find(params[:id])
    director.destroy
    redirect_to directors_url, notice: "Director deleted successfully"
  end
end
