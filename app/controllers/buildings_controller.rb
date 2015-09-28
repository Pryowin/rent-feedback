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
    if params[:search].nil? || params[:search].empty?
      @buildings = Building.paginate(page: params[:page])
    else
      @buildings = search_buildings(params[:search])
    end
  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show
    redirect_to buildings_path if @building.nil?
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
        format.html { redirect_to @building, notice: 'Building created.' }
        format.json { render :show, status: :created, location: @building }
      else
        format.html { render :new }
        err = @building.errors
        format.json { render json: err, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buildings/1
  # PATCH/PUT /buildings/1.json
  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to @building, notice: 'Building updated.' }
        format.json { render :show, status: :ok, location: @building }
      else
        format.html { render :edit }
        err = @building.errors
        format.json { render json: err, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.json
  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, notice: 'Building destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_building
    user_id = params[:id].to_i
    @building = Building.find(user_id) if Building.exists?(user_id)
  end

  # Never trust parameters from the scary internet, allow the white list
  def building_params
    params.require(:building).permit(:building_number,
                                     :street_name,
                                     :street_address_2,
                                     :street_address_3,
                                     :city,
                                     :state,
                                     :postal_code,
                                     :country)
  end

  def search_buildings(search)
    if search.match(/[^0-9]/)
      buildings = Building.where('postal_code=(?)', search)
    else
      search.downcase!
      wherec = 'lower(city)=? OR upper(state)=? OR lower(street_name) like(?)'
      buildings = Building.where(wherec,
                                 search, search.upcase, search + '%')
    end
    @buildings = buildings.paginate(page: params[:page])
  end
end
