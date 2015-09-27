class BuildingsController < ApplicationController

  include Sessions

  before_action :set_building, only: [:show, :edit, :update, :destroy]
  before_action :requires_authenticated_user,
                only: [:new, :create, :edit, :update, :destroy]
  before_action :requires_admin_user,
                only: [:edit, :update, :destroy]

  # GET /buildings
  # GET /buildings.json
  def index
    if params[:search].empty?
      @buildings =  Building.paginate(page: params[:page])
    else
      if !params[:search].match(/[^0-9]/)
        @buildings =  Building.where("postal_code=(?)",params[:search])
      else
        search = params[:search].downcase
        @buildings =  Building.where("lower(city)=? OR upper(state)=? OR lower(street_name) like(?)",
                                    search, search.upcase, search+"%").paginate(page: params[:page])
      end
    end
  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show
    # if !Building.exists?(params[:id])
    #   redirect_to buildings_path
    # end
    if @building.nil?
      redirect_to buildings_path
    end
  end

  # GET /buildings/new
  def new
    @building = Building.new
  end

  # GET /buildings/1/edit
  def edit
  end

  # POST /buildings
  # POST /buildings.json
  def create
    @building = Building.new(building_params)

    respond_to do |format|
      if @building.save
        format.html { redirect_to @building, notice: 'Building was successfully created.' }
        format.json { render :show, status: :created, location: @building }
      else
        format.html { render :new }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buildings/1
  # PATCH/PUT /buildings/1.json
  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to @building, notice: 'Building was successfully updated.' }
        format.json { render :show, status: :ok, location: @building }
      else
        format.html { render :edit }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.json
  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, notice: 'Building was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      if Building.exists?(params[:id])
        @building = Building.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_params
      params.require(:building).permit(:building_number,:street_name, :street_address_2, :street_address_3, :city, :state, :postal_code, :country)
    end
end
