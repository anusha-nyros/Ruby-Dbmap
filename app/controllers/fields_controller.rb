class FieldsController < ApplicationController
  before_filter :authorize
  # GET /fields
  # GET /fields.json
  def index
    @q = current_user.organization.fields.search(params[:q])
   @fields = @q.result.page(params[:page]).per(30)
#(:distinct  => true).find(:all,:order=>"updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fields }
    end
  end

  # GET /fields/1
  # GET /fields/1.json
  def show
    @field = Field.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @field }
    end
  end

  # GET /fields/new
  # GET /fields/new.json
  def new
    @field = Field.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @field }
    end
  end

  # GET /fields/1/edit
  def edit
    @field = Field.find(params[:id])
  end

  # POST /fields
  # POST /fields.json
  def create
    @field = Field.new(params[:field])
    @field.organization = current_user.organization
    @field.user = current_user

    respond_to do |format|
      if @field.save
        format.html { redirect_to @field, notice: 'Field was successfully created.' }
        format.json { render json: @field, status: :created, location: @field }
      else
        format.html { render action: "new" }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fields/1
  # PUT /fields/1.json
  def update
    @field = Field.find(params[:id])

    respond_to do |format|
      if @field.update_attributes(params[:field])
        format.html { redirect_to @field, notice: 'Field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @field = current_user.organization.fields.find(params[:id])
    @field.destroy

    respond_to do |format|
      format.html { redirect_to fields_url }
      format.json { head :no_content }
    end
  end

  def search
   
    @q = current_user.organization.fields.search(params[:q])
    if params[:q]
      @fields = @q.result(:distinct  => true).find(:all,:order=>"updated_at DESC")
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

end
