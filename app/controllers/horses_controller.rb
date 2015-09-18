class HorsesController < ApplicationController

  # GET /horses
  def index
    all_horses
  end

  # GET /horses/1
  def show
    horse
  end

  # GET /horses/new
  def new
    new_horse
  end
  
  # POST /horses
  def create
    if new_horse(horse_params).save
        redirect_to new_horse, notice: 'Horse was successfully created.'
    else
      render :new
    end
  end

# GET /horses/1/edit
  def edit
     horse
  end

  # PATCH/PUT /horses/1
  def update
    if horse.update(horse_params)
      redirect_to horse, notice: 'Horse was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /horses/1
  # DELETE /horses/1.json
  def destroy
    @horse.destroy
    redirect_to horses_url, notice: 'Horse was successfully destroyed.'
  end

private

  def all_horses
    @horse ||= Horse.all
  end

  def new_horse(attrs={})
    @horse ||= Horse.new(attrs)
  end

  def horse
    @horse ||= Horse.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def horse_params
    params.require(:horse).permit(:height, :name, :color)
  end
end
