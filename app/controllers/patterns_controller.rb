require 'rubygems'
require 'zip/zip'
require 'zip/zipfilesystem'

class PatternsController < ApplicationController
  before_filter :authorize
#skip_before_filter  :verify_authenticity_token
  #before_filter :get_logged
  
  # GET /categories
  # GET /categories.json
  def index
     params[:q] = {s: 'group asc'}.merge(params[:q] || {}) #order by color by default
    
    if params[:category].present?
      @category = Category.find(params[:category])
      params[:q][:category_id_eq] = @category.id
  else 
     #@category = Category.first(params[:category])
     #params[:q][:category_id_eq] = @category.id
     
    end

    @q = current_user.user_patterns.search(params[:q])
    if current_user.admin?
    	@patterns = @q.result#.page(params[:page]).per(12)
    else 
    	@patterns = @q.result.where('status != "Draft" or status is null')#.page(params[:page]).per(12)
    end 
    @categories = current_user.user_categories.order('position').all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patterns }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @pattern = current_user.user_patterns.find(params[:id])  
@categories = current_user.user_categories.order('position').all
  #  @search = @category.activities.search(params[:q])
#    if current_user.admin?
#       
#     @activities = @search.result.page params[:page]
#    
#    else
#    @activities = @search.result.where(:priority => 'Yes').page params[:page]
#    
#    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pattern }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @pattern = Pattern.new
    if params[:category]
      @category = current_user.organization.categories.find(params[:category])
      @pattern.category = @category
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pattern }
    end
  end

  # GET /categories/1/edit
  def edit
    @pattern = current_user.user_patterns.find(params[:id])

  end

  # POST /categories
  # POST /categories.json
  def create
    @category = sanitized_category(params[:pattern])
    @pattern = Pattern.new(params[:pattern])
    @pattern.organization = current_user.organization
    @pattern.category = @category
    
   
     if !params[:spectrum_color].blank?
      @pattern.color = params[:spectrum_color] 
    elsif !params[:common_color].blank?  
      @pattern.color = "#"+params[:common_color]
    elsif !params[:basic].blank?
      @pattern.color = "#fff" 
    end  
      
     if !params[:spectrum_front_color].blank?
      @pattern.fontcolor = params[:spectrum_front_color] 
    elsif !params[:common_front_color].blank?  
      @pattern.fontcolor = "#"+params[:common_front_color]
    elsif !params[:basic_front].blank?
      @pattern.fontcolor = "#fff" 
    end   


    respond_to do |format|
      if @pattern.save
        format.html { redirect_to patterns_path(category: @pattern.category), notice: 'Pattern was successfully created.' }
        format.json { render json: @pattern, status: :created, location: @pattern }
      else
        format.html { render action: "new" }
        format.json { render json: @pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    #render :text => params.inspect and return
    @category = sanitized_category(params[:pattern]) 
    
    current_user.user_patterns.find(params[:id]) # make sure it exists or else raise execption
    @pattern = Pattern.find(params[:id])
    @pattern.category = @category
   
    respond_to do |format|
      if @pattern.update_attributes(params[:pattern])

      if !params[:common_color].blank?  
      @pattern.color = "#"+params[:common_color] 
      elsif !params[:spectrum_color].blank?
      @pattern.color = params[:spectrum_color]  
      elsif !params[:basic].blank?
      @pattern.color = "#fff" 
      end  
      
    if !params[:spectrum_front_color].blank?
      @pattern.fontcolor = params[:spectrum_front_color] 
    elsif !params[:common_front_color].blank?  
      @pattern.fontcolor = "#"+params[:common_front_color]
    elsif !params[:basic_front].blank?
      @pattern.fontcolor = "#fff" 
    end  
          @pattern.save
        format.html { redirect_to pattern_path(@pattern), notice: 'Pattern was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @pattern = current_user.user_patterns.find(params[:id])
    @pattern.destroy

    respond_to do |format|
      format.html { redirect_to patterns_url }
      format.json { head :no_content }
    end
  end  
  def list_all_activities
    #@activities = current_user.user_activities.page(params[:page])
  end 
  #***************downloading patterns************
   def download_single_pattern
	@attachments = current_user.user_patterns.find(params[:id])
	if !@attachments.pat_html.blank? || !@attachments.pat_css.blank?  || !@attachments.pat_js.blank?
	zip_file_path = File.join("#{Rails.root}/public/uploads/","pattern_#{@attachments.name}.zip")
	if File.file?(zip_file_path)
	File.delete(zip_file_path)
	end
        if !@attachments.pat_html.blank?
        aFile = File.open(File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.html"), "w")
  	aFile.write(@attachments.pat_html)
  	aFile.close
        end
        if !@attachments.pat_css.blank?
        aFile1 = File.open(File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.css"), "w")
  	aFile1.write(@attachments.pat_css)
  	aFile1.close
        end
        if !@attachments.pat_js.blank?
        aFile2 = File.open(File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.js"), "w")
  	aFile2.write(@attachments.pat_js)
  	aFile2.close
        end
	# creating a zip file of files
	Zip::ZipFile.open(zip_file_path, Zip::ZipFile::CREATE) { |zipfile|
        if aFile then zipfile.add(File.basename(aFile),File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.html")) end 
        if aFile1 then zipfile.add(File.basename(aFile1),File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.css")) end 
        if aFile2 then zipfile.add(File.basename(aFile2),File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.js")) end 
	} 
	#send the file as an attachment to the user.
	send_file zip_file_path, :type => 'application/zip', :disposition => 'attachment', :filename => "pattern_#{@attachments.name}.zip"
        File.delete(File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.html")) if aFile
	 File.delete(File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.css")) if aFile1
	 File.delete(File.join("#{Rails.root}/public/uploads/","#{@attachments.name}.js")) if aFile2
        File.delete(File.join("#{Rails.root}/public/uploads/","pattern_#{@attachments.name}.zip"))
        else
        redirect_to pattern_path(@attachments) , :flash => { :error=> "There is no code available to download for this pattern" } 
        end 
      
    end
#***************single downloading patterns************
#***************multiple downloading patterns************
   def download_patterns
        if current_user.admin?
		@attachments = current_user.user_patterns
        else
		@attachments = current_user.user_patterns.where('status != "Draft" or status is null')
	end 
	zip_file_pattern_path = File.join("#{Rails.root}/public/uploads/","patterns.zip")
	if File.file?(zip_file_pattern_path)
	File.delete(zip_file_pattern_path)
	end

	@attachments.each do |attachment| #loop for all patterns
	# creating a zip file of single pattern related files

	if !attachment.pat_html.blank? || !attachment.pat_css.blank?  || !attachment.pat_js.blank?
	zip_file_path = File.join("#{Rails.root}/public/uploads/","pattern_#{attachment.name}.zip")
	if File.file?(zip_file_path)
	File.delete(zip_file_path)
	end
        if !attachment.pat_html.blank?
        aFile = File.open(File.join("#{Rails.root}/public/uploads/","#{attachment.name}.html"), "w")
  	aFile.write(attachment.pat_html)
  	aFile.close
        end
        if !attachment.pat_css.blank?
        aFile1 = File.open(File.join("#{Rails.root}/public/uploads/","#{attachment.name}.css"), "w")
  	aFile1.write(attachment.pat_css)
  	aFile1.close
        end
        if !attachment.pat_js.blank?
        aFile2 = File.open(File.join("#{Rails.root}/public/uploads/","#{attachment.name}.js"), "w")
  	aFile2.write(attachment.pat_js)
  	aFile2.close
        end
	# creating a zip file of single pattern related files
	Zip::ZipFile.open(zip_file_path, Zip::ZipFile::CREATE) { |zipfile|
        if aFile then zipfile.add(File.basename(aFile),File.join("#{Rails.root}/public/uploads/","#{attachment.name}.html")) end 
        if aFile1 then zipfile.add(File.basename(aFile1),File.join("#{Rails.root}/public/uploads/","#{attachment.name}.css")) end 
        if aFile2 then zipfile.add(File.basename(aFile2),File.join("#{Rails.root}/public/uploads/","#{attachment.name}.js")) end 
	} 
	Zip::ZipFile.open(zip_file_pattern_path, Zip::ZipFile::CREATE) { |zipfile_pattern|
        zipfile_pattern.add(File.basename(zip_file_path),zip_file_path)
        } 
 	#send the file as an attachment to the user.
        File.delete(File.join("#{Rails.root}/public/uploads/","#{attachment.name}.html")) if aFile
	 File.delete(File.join("#{Rails.root}/public/uploads/","#{attachment.name}.css")) if aFile1
	 File.delete(File.join("#{Rails.root}/public/uploads/","#{attachment.name}.js")) if aFile2
        File.delete(File.join("#{Rails.root}/public/uploads/","pattern_#{attachment.name}.zip"))

        end 
        end #loop end for all patterns

        if File.file?(zip_file_pattern_path)
	send_file zip_file_pattern_path, :type => 'application/zip', :disposition => 'attachment', :filename => "patterns.zip" 
      	if File.file?(zip_file_pattern_path) then File.delete(File.join("#{Rails.root}/public/uploads/","patterns.zip")) end 
        else
          redirect_to patterns_path , :flash => { :error=> "There is no code available to download in the patterns." } 
        end 
    end

#*************** multiple downloading patterns************
  private
  def sanitized_category(params)
    #sanitize folder_id
    category_id = params.delete(:category_id)
    if category_id.present?
      @category = current_user.organization.categories.find(category_id)
    end
  end
end  
