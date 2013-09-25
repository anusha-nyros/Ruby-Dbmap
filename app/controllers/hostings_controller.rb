class HostingsController < ApplicationController
  # GET /hostings
  # GET /hostings.json
  before_filter :authorize
  def index
    @q =   current_user.organization.hostings.search(params[:q])
    @hostings = @q.result.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hostings }
    end
  end

  # GET /hostings/1
  # GET /hostings/1.json
  def show
    @hosting = Hosting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hosting }
    end
  end

  # GET /hostings/new
  # GET /hostings/new.json
  def new
    @hosting = Hosting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hosting }
    end
  end

  # GET /hostings/1/edit
  def edit
    @hosting = current_user.organization.hostings.find(params[:id])
  end

  # POST /hostings
  # POST /hostings.json
  def create
    @hosting = Hosting.new(params[:hosting])
    @hosting.organization = current_user.organization
    @hosting.user = current_user

    respond_to do |format|
      if @hosting.save
        format.html { redirect_to @hosting, notice: 'Instance record was successfully created.' }
        format.json { render json: @hosting, status: :created, location: @hosting }
      else
        format.html { render action: "new" }
        format.json { render json: @hosting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hostings/1
  # PUT /hostings/1.json
  def update
    @hosting = current_user.organization.hostings.find(params[:id])

    respond_to do |format|
      if @hosting.update_attributes(params[:hosting])
        format.html { redirect_to @hosting, notice: 'Instance record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hosting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hostings/1
  # DELETE /hostings/1.json
  def destroy
    @hosting = current_user.organization.hostings.find(params[:id])
    @hosting.destroy

    respond_to do |format|
      format.html { redirect_to hostings_url }
      format.json { head :no_content }
    end
  end
  def search
   
    @q = current_user.organization.hostings.search(params[:q])
    if params[:q]
      @hostings = @q.result(:distinct  => true).page(params[:page])
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
end
