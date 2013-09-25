class EnvironmentsController < ApplicationController
  # GET /environments
  # GET /environments.json
  before_filter :authorize
  def index
    @environments = current_user.organization.environments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @environments }
    end
  end

  # GET /environments/1
  # GET /environments/1.json
  def show
    @environment = current_user.organization.environments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @environment }
    end
  end

  # GET /environments/new
  # GET /environments/new.json
  def new
    @environment = Environment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @environment }
    end
  end

  # GET /environments/1/edit
  def edit
    @environment = current_user.organization.environments.find(params[:id])
  end

  # POST /environments
  # POST /environments.json
  def create
    @environment = Environment.new(params[:environment])
    @environment.organization = current_user.organization
    @environment.user = current_user

    respond_to do |format|
      if @environment.save
        format.html { redirect_to @environment, notice: 'Instance record was successfully created.' }
        format.json { render json: @environment, status: :created, location: @environment }
      else
        format.html { render action: "new" }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /environments/1
  # PUT /environments/1.json
  def update
    @environment = current_user.organization.environments.find(params[:id])

    respond_to do |format|
      if @environment.update_attributes(params[:environment])
        format.html { redirect_to @environment, notice: 'Instance record  was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environments/1
  # DELETE /environments/1.json
  def destroy
    @environment = current_user.organization.environments.find(params[:id])
    @environment.destroy

    respond_to do |format|
      format.html { redirect_to environments_url }
      format.json { head :no_content }
    end
  end
end
