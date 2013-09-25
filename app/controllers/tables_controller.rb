class TablesController < ApplicationController
  before_filter :authorize
  # GET /tables
  # GET /tables.json
=begin
  def index
 # @databases = current_user.organization.databases.page(params[:page]).per(30)
  @q  = current_user.organization.tables.search(params[:q])
    #@databases = current_user.organization.databases
    #@q = @databases.tables.search(params[:q])
    @tables =  @q.result.page(params[:page]).per(30)
    #@tables = @q.result(:distinct  => true).find(:all,:order=>"updated_at DESC")
    #@tables = @q.result().find(:all,:order=>"updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tables }
    end
  end
=end
  def index

  if params[:table]
   if params[:table]["db_datab"] != "All"
    @q = current_user.organization.tables.where(:database_name => params[:table]["db_datab"]).search(params[:q])
  else
    @q  = current_user.organization.tables.search(params[:q])
  end
    @tables =  @q.result.page(params[:page]).per(30)
  else
    @q  = current_user.organization.tables.search(params[:q])
    @tables =  @q.result.page(params[:page]).per(30)
    #@tables = @q.result(:distinct  => true).find(:all,:order=>"updated_at DESC")
    #@tables = @q.result().find(:all,:order=>"updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tables }
    end
 end


   end
  # GET /tables/1
  # GET /tables/1.json
  def show
    #@table = current_user.organization.tables.find(params[:id])
    @table = Table.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @table }
    end
  end

  # GET /tables/new
  # GET /tables/new.json
  def new
    @table = Table.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @table }
    end
  end

  # GET /tables/1/edit
  def edit
    @table = Table.find(params[:id])
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(params[:table])
    @table.organization = current_user.organization
    @table.user = current_user

    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: 'Table was successfully created.' }
        format.json { render json: @table, status: :created, location: @table }
      else
        format.html { render action: "new" }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tables/1
  # PUT /tables/1.json
  def update
    @table =Table.find(params[:id])

    respond_to do |format|
      if @table.update_attributes(params[:table])
        format.html { redirect_to @table, notice: 'Table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table = current_user.organization.tables.find(params[:id])
    @table.destroy

    respond_to do |format|
      format.html { redirect_to tables_url }
      format.json { head :no_content }
    end
  end
  def search

    @q = current_user.organization.tables.search(params[:q])
    if params[:q]
      @tables = @q.result#(:distinct  => true).find(:all,:order=>"updated_at DESC")
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  
end
