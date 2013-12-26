class VolumesController < ApplicationController
  before_action :set_volume, only: [:show, :edit, :update, :destroy]

  # GET /volumes
  # GET /volumes.json
  def index
    @volumes = Volume.all.page(params[:page])
  end

  # GET /volumes/1
  # GET /volumes/1.json
  def show
    set_volume
    @papers = @volume.papers.page(params[:page]).per(20)
    @editors = @volume.people
    #Kaminari.paginate_array(@volume.papers).page(params[:page]).per(10)
    #@volume.papers = Paper.all.where(:anthology_id => @volume.anthology_id)
  end

  # GET /volumes/new
  def new
    @volume = Volume.new
  end

  # GET /volumes/1/edit
  def edit
  end

  # POST /volumes
  # POST /volumes.json
  def create
    @volume = Volume.new(volume_params)
    respond_to do |format|
      if @volume.save
        format.html { redirect_to @volume, notice: 'Volume was successfully created.' }
        format.json { render action: 'show', status: :created, location: @volume }
      else
        format.html { render action: 'new' }
        format.json { render json: @volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /volumes/1
  # PATCH/PUT /volumes/1.json
  def update
    respond_to do |format|
      if @volume.update(volume_params)
        format.html { redirect_to @volume, notice: 'Volume was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volumes/1
  # DELETE /volumes/1.json
  def destroy
    @volume.destroy
    respond_to do |format|
      format.html { redirect_to volumes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volume
      @volume = Volume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volume_params
      params.require(:volume).permit(:anthology_id, :title, :month, :year, :address, :publisher, :url, :bibtype, :bibkey)
    end
end