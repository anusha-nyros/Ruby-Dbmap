#encoding: utf-8
require 'rubygems'
require 'prawn/images'
require 'prawn/layout'
class ReportPdf < Prawn::Document
  def initialize(document,type,fields1,data,not_used)
    super(:margin => [70,50,50,50])
    @document = document
     @type = type
     @fields1 = fields1
     @data = data 
     @not_used = not_used
    stroke_color '000080'
    font "Helvetica"  
    font_size  8
    content_items
    (page_count-1).times do |i|
      go_to_page(i+2)
      draw_text "Page #{i+1} of #{page_count-1}" ,:at=>[225,-30]
      draw_text "Database Analysis" ,:at=>[0,711],:size => 9
      draw_text "#{@document.db_name}" ,:at=>[214,711],:size => 9, :style => :bold
      draw_text "#{Date.today.strftime('%B %d, %Y')}" ,:at=>[445,711],:size => 9
   end
  end 
  
  def content_items
  stroke do
  # just lower the current y position
  move_down 255
  horizontal_rule
  move_down 25
  text "<color rgb='000080'>#{@document.db_name}</color>",size: 36 ,:align => :center, inline_format: true
  move_down 25
  horizontal_rule
  move_down 40
  end
  text "<b>#{Date.today.strftime('%m/%d/%y')}</b>",size: 11 ,:align => :right, inline_format: true
  move_down 20
  text "<b>Database Analysis</b>",size: 11 ,:align => :right, inline_format: true
  move_down 20
  text "Tables-Fields-Views",size: 11 ,:align => :right
  # Table of contents page 
  start_new_page
  move_down 30
  text "Table of Contents",size: 22 ,:align => :center
  text "\n"
  move_down 15
  text "Database Summary",size: 14 ,:align => :left
  move_down 10
  text "Recap by Table Type",size: 14 ,:align => :left
  move_down 10
  text "Recap by Feature/Module",size: 14 ,:align => :left
  move_down 10
  
  text "All Tables List",size: 14 ,:align => :left
  move_down 10
  if !@type.blank? # for table type condition
  text "Tables by Type",size: 14 ,:align => :left
  text "\n"
  [[["","Maintenance"]],[["","Recap"]],[["","Setup"]],[["","Transactional"]],[["","View"]],[["","Not Defined"]]].each do |k|
  table(k, :cell_style => { :borders => []},:column_widths => { 0 => 50, 1 => 450}) do
    style(columns(1)) {|x| x.align = :left}
    style row(0),:size=>12
  end
  end 
  move_down 10
  end # end for table by type condtion
  if !@fields1.blank? 
  text "Fields List",size: 14 ,:align => :left
  move_down 10
  end 
  if !@data.blank?
  text "Data Samples",size: 14 ,:align => :left
  move_down 10
  end
  start_new_page

  @tables_count = @document.tables.length
  @tables_not_used = @document.tables.where(:ofrows => 0).count
#  #-------------------------- databases info ------------------------------#
#  text "\n"
#  text "\n"
#  text "\n"

#  text "Databases Info",size: 13 ,:align => :center
#  text "\n"
#  text "\n"
#  databases_info = [["Database","Active Tables", "Total Tables","# Of Rows", "Total Fields"]]
#   table(databases_info, :header => true, :cell_style => { :borders => []},
#  :column_widths => { 0 => 175, 1 => 100, 2 => 75,3 => 75,4=>75}) do
#    style(columns(4)) {|x| x.align = :center}
#    style row(0), :background_color => "8EB2E2",:size=>12
#  end
#  databases_info1 = [["#{@document.db_name}","#{@document.tables.length - @tables_not_used}", "#{@document.tables.length}","#{@document.tables.sum('ofrows')}", "#{@document.tables.sum('ofcolumns')}"]]
#   table(databases_info1,  :cell_style => { :borders => []},
#  :column_widths => { 0 => 175, 1 => 100, 2 => 75,3 => 75,4=>75}) do
#    style(columns(4)) {|x| x.align = :center}
#    style(column(0),:font_style => :bold)
#  end
#  databases_info2 = [["Grand Totals","#{@document.tables.length - @tables_not_used}", "#{@document.tables.length}","#{@document.tables.sum('ofrows')}", "#{@document.tables.sum('ofcolumns')}"]]
#   table(databases_info2, :cell_style => { :borders => []},
#  :column_widths => { 0 => 175, 1 => 100, 2 => 75,3 => 75,4=>75}) do
#    style(columns(4)) {|x| x.align = :center}
#  end
#  text "\n"
#  text "\n"
#  #-----------------------End Databases Info ------------------------------#
  text "\n"
  text "\n"
  text "\n"
  move_down 7
   text "Database Summary",size: 20 ,:align => :center, inline_format: true
  move_down 28

  table_types_pg1 = [["Database:","#{@document.db_name}"]]
   table(table_types_pg1, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(1)) {|x| x.align = :left}
    style(column(0..1),:font_style => :bold,:text_color => '000080')
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end
  table_types_pg1_desc = [["","#{@document.db_usage}"]]
   table(table_types_pg1_desc, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(1)) {|x| x.align = :left}
    style row(0),:size=>10
  end
  text "\n"
  text "\n"
  table_types_pg4 = [["Total Tables:","#{number_with_delimiter(@document.tables.length)}"]]
   table(table_types_pg4, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end
  table_types_pg6 = [["Total Fields:","#{number_with_delimiter(@document.tables.sum('ofcolumns'))}"]]
   table(table_types_pg6, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end
  table_types_pg2 = [["Active Tables:","#{@document.tables.length - @tables_not_used}"]]
   table(table_types_pg2, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end
  table_types_pg3 = [["Tables not used:","#{@tables_not_used}"]]
   table(table_types_pg3, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end

  table_types_pg5 = [["#Of Records:","#{number_with_delimiter(@document.tables.sum('ofrows'))}"]]
   table(table_types_pg5, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end

 table_types_pg7 = [["Last Sync:","#{@document.last_sync.strftime("%b-%d-%Y") if !@document.last_sync.blank? }"]]
   table(table_types_pg7, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end

table_types_pg8 = [["Environment:","#{@document.db_environment }"]]
   table(table_types_pg8, :cell_style => { :borders => []},
  :column_widths => { 0 => 130, 1 => 370}) do
    style(columns(0..1)) {|x| x.align = :left}
    style(column(0),:text_color => '000080')
    style row(0),:size=>14
  end
  text "\n"
  text "\n"
  text "\n"
=begin
  text "Table Types are described as follows:",:size=>11

  text "\n"
  table_types_desc1 = [["Maintenance","- Used to strore information which is referenced by transactional table to validate data capture. Changed on demand,but is not transactional in nature."]]
   table(table_types_desc1, :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 400}) do
    style(columns(1)) {|x| x.align = :left}
    style(column(0),:font_style => :bold)
    style row(0),:size=>10
  end
  table_types_desc2 = [["Recap","- Work tables which are either temporary or used to store calculated information."]]
   table(table_types_desc2, :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 400}) do
    style(columns(1)) {|x| x.align = :left}
    style(column(0),:font_style => :bold)
    style row(0),:size=>10
  end
  table_types_desc3 = [["Setup","- Tables which hold overall setup parameters and switches for the application."]]
   table(table_types_desc3, :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 400}) do
    style(columns(1)) {|x| x.align = :left}
    style(column(0),:font_style => :bold)
    style row(0),:size=>10
  end
  table_types_desc4 = [["Transactional","- Stores transaction information from the application. These tables usually maintain the most records and are updated on a regular basis."]]
   table(table_types_desc4, :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 400}) do
    style(columns(1)) {|x| x.align = :left}
    style(column(0),:font_style => :bold)
    style row(0),:size=>10
  end
  table_types_desc5 = [["View","- Is a view made up of one or multiple tables."]]
   table(table_types_desc5, :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 400}) do
    style(columns(1)) {|x| x.align = :left}
    style(column(0),:font_style => :bold)
    style row(0),:size=>10
  end


  #-----------------------Summary Info ------------------------------#
  start_new_page
  text "Database: #{@document.db_name}",size: 13 ,:align => :center
  text "\n"
  text "\n"
 text " Summary",size: 13
  text "\n"
  text "\n"
  summary_info = [["Active Tables","Tables Not Used", "Total Tables","Total records", "Total Fields","Estimated Size"]]
   table(summary_info, :header => true, :cell_style => { :borders => []},
  :column_widths => { 0 => 80, 1 => 100, 2 => 80,3 => 80,4=>80,5=>80}) do
    style(columns(5)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end

  summary_info1 = [["#{@document.tables.length - @tables_not_used}","#{@tables_not_used}", "#{@document.tables.length}","#{@document.tables.sum('ofrows')}", "#{@document.tables.sum('ofcolumns')}",""]]
   table(summary_info1,:cell_style => { :borders => []},
  :column_widths => { 0 => 80, 1 => 100, 2 => 80,3 => 80,4=>80,5=>80}) do
    style(columns(5)) {|x| x.align = :center}
  end
  text "\n"
  text "\n"

  #-----------------------End Summary Info ------------------------------#
=end
  #------------------Recap by Table Type --------------------------------#
  start_new_page
  @main_table_cnt = @document.tables.where(:table_type => 'Maintenance')
  @recap_table_cnt = @document.tables.where(:table_type => 'Recap') 
  @setup_table_cnt = @document.tables.where(:table_type => 'Setup') 
  @trans_table_cnt = @document.tables.where(:table_type => 'Transactional') 
  @view_table_cnt = @document.tables.where(:table_type => 'View') 
  @not_def = @document.tables.where("table_type IS  NULL  OR table_type = ''")
  @grand_of_tables = @main_table_cnt.length + @recap_table_cnt.length + @setup_table_cnt.length + @view_table_cnt.length + @trans_table_cnt.length + @not_def.length
  @grand_of_rows =  @main_table_cnt.sum('ofrows') + @recap_table_cnt.sum('ofrows') + @setup_table_cnt.sum('ofrows') + @trans_table_cnt.sum('ofrows') + @view_table_cnt.sum('ofrows') + @not_def.sum('ofrows')
  @grand_of_cols =  @main_table_cnt.sum('ofcolumns') + @recap_table_cnt.sum('ofcolumns') + @setup_table_cnt.sum('ofcolumns') + @trans_table_cnt.sum('ofcolumns') + @view_table_cnt.sum('ofcolumns') + @not_def.sum('ofcolumns')

  text " Recap by Table Type",size: 13
  text "\n"
  recap_table_header = [["Table Type","Description","# Of Tables", "# Of Fields", "# Of Rows"]]
   table(recap_table_header, :header => true, :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
  maintenance_table_row = [["Maintenance","Used to store information which is referenced by transactional table to validate data capture. Changed on demand,but is not transactional in nature.","#{@main_table_cnt.length}", "#{number_with_delimiter(@main_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@main_table_cnt.sum('ofrows'))}"]]
   table(maintenance_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end

  recap_table_row = [["Recap","Work tables which are either temporary or used to store calculated information.","#{@recap_table_cnt.length}", "#{number_with_delimiter(@recap_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@recap_table_cnt.sum('ofrows'))}"]]
   table(recap_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end

  setup_table_row = [["Setup","Tables which hold overall setup parameters and switches for the application.","#{@setup_table_cnt.length}", "#{number_with_delimiter(@setup_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@setup_table_cnt.sum('ofrows'))}"]]
   table(setup_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end	
  trans_table_row = [["Transactional","Stores transaction information from the application. These tables usually maintain the most records and are updated on a regular basis.","#{@trans_table_cnt.length}", "#{number_with_delimiter(@trans_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@trans_table_cnt.sum('ofrows'))}"]]
   table(trans_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end

  view_table_row = [["View","Is a view made up of one or multiple tables.","#{@view_table_cnt.length}", "#{number_with_delimiter(@view_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@view_table_cnt.sum('ofrows'))}"]]
   table(view_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end

#  notused_table_row = [["Not Used","","#{@document.tables.where(:ofrows => 0).length}", "#{number_with_delimiter(@document.tables.where(:ofrows => 0).sum('ofcolumns'))}", "#{number_with_delimiter(@document.tables.where(:ofrows => 0).sum('ofrows'))}"]]
#   table(notused_table_row,  :cell_style => { :borders => []},
#  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
#    style(columns(4)) {|x| x.align = :center}
#        style(column(0),:font_style => :bold)
#  end

 notdef_table_row = [["Not Defined","Tables which type is not yet defined","#{@not_def.length}", "#{number_with_delimiter(@not_def.sum('ofcolumns'))}", "#{number_with_delimiter(@not_def.sum('ofrows'))}"]]
   table(notdef_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end


  grand_table_row = [["Grand Totals","","#{@grand_of_tables}", "#{number_with_delimiter(@grand_of_cols)}", "#{number_with_delimiter(@grand_of_rows)}"]]
   table(grand_table_row,  
  :column_widths => { 0 => 100, 1 => 190, 2 => 70,3 => 70,4 => 70}) do
    style(columns(4)) {|x| x.align = :center}
        style(column(0..4),:font_style => :bold)
  end
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  start_new_page
  #------------------End Recap by Table Type --------------------------------#

  #
  #
  #
  #
  #--------------------------------Recap Feature/Section/Module------------------#

  @feature_table_cnt = @document.tables.where(:feature_types => 'Feature')
  @module_table_cnt = @document.tables.where(:feature_types => 'Module') 
  @section_table_cnt = @document.tables.where(:feature_types => 'Section') 
  @grand_of_tables = @feature_table_cnt.length + @module_table_cnt.length + @section_table_cnt.length
  @grand_of_rows =  @feature_table_cnt.sum('ofrows') + @module_table_cnt.sum('ofrows') + @section_table_cnt.sum('ofrows') 
  @grand_of_cols =  @feature_table_cnt.sum('ofcolumns') + @module_table_cnt.sum('ofcolumns') + @section_table_cnt.sum('ofcolumns') 

  text " Recap by Feature/Module/Section",size: 13
  text "\n"
  recap_table_header = [["Feature/Module/Section","# Of Tables", "# Of Fields", "# Of Rows"]]
   table(recap_table_header, :header => true, :cell_style => { :borders => []},
  :column_widths => { 0 => 200, 1 => 100, 2 => 100,3 => 100}) do
    style(columns(3)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
  maintenance_table_row = [["Feature","#{@feature_table_cnt.length}", "#{number_with_delimiter(@feature_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@feature_table_cnt.sum('ofrows'))}"]]
   table(maintenance_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 200, 1 => 100, 2 => 100,3 => 100}) do
    style(columns(3)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end

  recap_table_row = [["Module","#{@module_table_cnt.length}", "#{number_with_delimiter(@module_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@module_table_cnt.sum('ofrows'))}"]]
   table(recap_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 200, 1 => 100, 2 => 100,3 => 100}) do
    style(columns(3)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end

  setup_table_row = [["Section","#{@section_table_cnt.length}", "#{number_with_delimiter(@section_table_cnt.sum('ofcolumns'))}", "#{number_with_delimiter(@section_table_cnt.sum('ofrows'))}"]]
   table(setup_table_row,  :cell_style => { :borders => []},
  :column_widths => { 0 => 200, 1 => 100, 2 => 100,3 => 100}) do
    style(columns(3)) {|x| x.align = :center}
        style(column(0),:font_style => :bold)
  end	
   grand_table_row = [["Grand Totals","#{@grand_of_tables}", "#{number_with_delimiter(@grand_of_cols)}", "#{number_with_delimiter(@grand_of_rows)}"]]
   table(grand_table_row,  
  :column_widths => { 0 => 200, 1 => 100, 2 => 100,3 => 100}) do
    style(columns(3)) {|x| x.align = :center}
        style(column(0..3),:font_style => :bold)
  end
  text "\n"
  text "\n"
  #------------------End Recap by Feature/Section/Module --------------------------------#

   
  #-----------------------Top Tables -------------------------------#

  
   start_new_page
  move_down 20
  
 text "\n"
  text "Top Tables" ,size: 12
  text " - Tables  which are most commonly used in this  Database",:indent_paragraphs => 20
 
 text "\n"
  text "\n"
   @top_used = @document.tables.where(:top_used => 1)
   if !@top_used.blank?
      top_table_header = [["Table Name","Description"]]
      table(top_table_header, :header => true, :column_widths => { 0 => 100, 1 => 400}) do
      style(columns(3)) {|x| x.align = :center}
      style row(0), :background_color => "8EB2E2",:size=>12
      end

    @top_used.each do |t|
    top_fields = [[t.table_name,t.description]]
     table(top_fields, :header => false,
       :column_widths => { 0 => 100, 1 => 400}) do
    end
   end
  else 
   text "No Top Tables to display."
   text "\n"
  end 


  
  
  #-----------------------Top Tables End -------------------------------#


  #------------------All Tables Info --------------------------------#
   start_new_page
  text " All Tables Info:",size: 13
  text "\n"
  text "\n"
  all_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(all_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
  @document.tables.each do |t|
  if t.ofrows != 0 
  @ofr = "Yes"
  else
  @ofr = "No"
  end 
  all_tab1 = [["#{t.table_name}","#{t.description}", "#{t.table_type}","#{number_with_delimiter(t.ofrows)}", "#{@ofr}"]]
   table(all_tab1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  text "\n"
  text "\n"

  #------------------End All Tables Info --------------------------------#
  #------------------Type wise Tables Info --------------------------------#
  if !@type.blank?
  if @main_table_cnt.length != 0
    if @main_table_cnt.length == 1
  text " Maintenance (#{@main_table_cnt.length} Table)",size: 13
    else
  text " Maintenance (#{@main_table_cnt.length} Tables)",size: 13
    end
  text "\n"
  text " - Used to store information which is referenced by transactional table to validate data capture. Changed on demand,but is not transactional in nature."
  text "\n"
    if @main_table_cnt.length != 0
  maint_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(maint_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @main_table_cnt.each do |k1|
  if k1.ofrows != 0 
  @ofrk1 = "Yes"
  else
  @ofrk1 = "No"
  end 
  maint_tab1 = [["#{k1.table_name}","#{k1.description}", "#{k1.table_type}","#{number_with_delimiter(k1.ofrows)}", "#{ @ofrk1}"]]
   table(maint_tab1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No Maintenance tables to display"
  end 
  text "\n"
  text "\n"
  end


 if  @recap_table_cnt.length != 0
    if @recap_table_cnt.length == 1
  text " Recap (#{ @recap_table_cnt.length} Table)",size: 13
    else
  text " Recap (#{@recap_table_cnt.length} Tables)",size: 13
    end
  text "\n"
 text " - Work tables which are either temporary or used to store calculated information."
 text "\n"
 if  @recap_table_cnt.length != 0
  rec_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(rec_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @recap_table_cnt.each do |k2|
  if k2.ofrows != 0 
  @ofrk2 = "Yes"
  else
  @ofrk2 = "No"
  end 
  rec_tab1 = [["#{k2.table_name}","#{k2.description}", "#{k2.table_type}","#{number_with_delimiter(k2.ofrows)}", "#{ @ofrk2}"]]
   table(rec_tab1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No Recap tables to display"
  end
  text "\n"
  text "\n"
  end
 if  @setup_table_cnt.length != 0
    if @setup_table_cnt.length == 1
 text " Setup (#{@setup_table_cnt.length} Table)",size: 13
    else
 text " Setup (#{@setup_table_cnt.length} Tables)",size: 13
    end
  text "\n"
  text " - Tables which hold overall setup parameters and switches for the application."
  text "\n"
 if  @setup_table_cnt.length != 0
  setup_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(setup_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @setup_table_cnt.each do |k3|
  if k3.ofrows != 0 
  @ofrk3 = "Yes"
  else
  @ofrk3 = "No"
  end 
  setup_tab1 = [["#{k3.table_name}","#{k3.description}", "#{k3.table_type}","#{number_with_delimiter(k3.ofrows)}", "#{ @ofrk3}"]]
   table(setup_tab1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No Setup tables to display"
  end
  text "\n"
  text "\n"
  end
 if  @trans_table_cnt.length != 0
    if @trans_table_cnt.length == 1
 text " Transactional (#{@trans_table_cnt.length} Table)",size: 13
    else
 text " Transactional (#{@trans_table_cnt.length} Tables)",size: 13
    end
  text "\n"
  text " - Stores transaction information from the application. These tables usually maintain the most records and are updated on a regular basis."
  text "\n"
 if  @trans_table_cnt.length != 0
  trans_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(trans_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @trans_table_cnt.each do |k4|
  if k4.ofrows != 0 
  @ofrk4 = "Yes"
  else
  @ofrk4 = "No"
  end 
  trans1 = [["#{k4.table_name}","#{k4.description}", "#{k4.table_type}","#{number_with_delimiter(k4.ofrows)}", "#{ @ofrk4}"]]
   table(trans1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No Transactional tables to display"
  end
  text "\n"
  text "\n"
  end

 if  @view_table_cnt.length != 0
    if @view_table_cnt.length == 1
  text " View (#{@view_table_cnt.length} Table)",size: 13
    else
  text " View (#{@view_table_cnt.length} Tables)",size: 13
    end
  text "\n"
  text "\n"
  text " - Is a view made up of one or multiple tables."
    text "\n"
 if  @view_table_cnt.length != 0
  view_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(view_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @view_table_cnt.each do |k5|
  if k5.ofrows != 0 
  @ofrk5 = "Yes"
  else
  @ofrk5 = "No"
  end 
  view1 = [["#{k5.table_name}","#{k5.description}", "#{k5.table_type}","#{number_with_delimiter(k5.ofrows)}", "#{ @ofrk5}"]]
   table(view1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No View tables to display"
  end
  text "\n"
  text "\n"
  end
 end #end for loop
 # table for not defined pdf page 
 if  @not_def.length != 0
    if @not_def.length == 1
  text " Not Defined (#{@not_def.length} Table)",size: 13
    else
  text " Not Defined (#{@not_def.length} Tables)",size: 13
    end
  text "\n"
  text "\n"
  text " - Tables that their table type is not yet defined."
    text "\n"
 if  @not_def.length != 0
  view_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(view_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @not_def.each do |k5|
  if k5.ofrows != 0 
  @ofrk5 = "Yes"
  else
  @ofrk5 = "No"
  end 
  view1 = [["#{k5.table_name}","#{k5.description}", "#{k5.table_type}","#{number_with_delimiter(k5.ofrows)}", "#{ @ofrk5}"]]
   table(view1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No tables to display"
  end
  text "\n"
  text "\n"
  end


 # end for not defined pdf page 


 if !@not_used.blank? # for not used tables 
 if  @document.tables.where(:ofrows => 0).length != 0
    if @document.tables.where(:ofrows => 0).length == 1
  text " Not Used (1 Table)",size: 13
    else
  text " Not Used (#{@document.tables.where(:ofrows => 0).length} Tables)",size: 13
    end
  text "\n"
  text " - Tables that have no records yet."
  text "\n"
 if  @document.tables.where(:ofrows => 0).length != 0
  not_used_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(not_used_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
@document.tables.where(:ofrows => 0).each do |k6|
  if k6.ofrows != 0 
  @ofrk6 = "Yes"
  else
  @ofrk6 = "No"
  end 
  not_used1 = [["#{k6.table_name}","#{k6.description}", "#{k6.table_type}","#{number_with_delimiter(k6.ofrows)}", "#{ @ofrk6}"]]
   table(not_used1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No  tables to display"
  end
  text "\n"
  text "\n"
  end

   end # for not used tables 

if (@document.tables.length - @tables_not_used) !=0
    if @document.tables.length - @tables_not_used == 1
  text " Active ( 1 Table)",size: 13
    else
  text " Active (#{@document.tables.length - @tables_not_used} Tables)",size: 13
    end
  text "\n"
  text "- Tables that are active/having atleast one record."
  text "\n"
if (@document.tables.length - @tables_not_used) !=0
  not_act_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(not_act_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @activ_tables = @document.tables.where('ofrows != 0')
 @activ_tables.each do |k7|
  if k7.ofrows != 0 
  @ofrk7 = "Yes"
  else
  @ofrk7 = "No"
  end 
  not_act1 = [["#{k7.table_name}","#{k7.description}", "#{k7.table_type}","#{number_with_delimiter(k7.ofrows)}", "#{ @ofrk7}"]]
   table(not_act1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No tables to display"
  end
  text "\n"
  text "\n"
  end

 

if @tables_not_used !=0
    if @tables_not_used  == 1
 text " Not Active (#{@tables_not_used} Table)",size: 13
    else
 text " Not Active (#{@tables_not_used} Tables)",size: 13
    end
  text "\n"
  text " - Tables that are inactive/having no records."
  text "\n"
if @tables_not_used !=0
  in_act_tab = [["Table Name","Usage","Table Type", "Of Rows","Used?"]]
   table(in_act_tab, :header => true, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
@inactiv_tables = @document.tables.where(:ofrows => 0)
 @inactiv_tables.each do |k8|
  if k8.ofrows != 0 
  @ofrk8 = "Yes"
  else
  @ofrk8 = "No"
  end 
  in_act_tab1 = [["#{k8.table_name}","#{k8.description}", "#{k8.table_type}","#{number_with_delimiter(k8.ofrows)}", "#{ @ofrk8}"]]
   table(in_act_tab1, 
  :column_widths => { 0 => 100, 1 => 150, 2 => 100,3 => 75,4=>75}) do
    style(columns(4)) {|x| x.align = :center}
    style(column(0),:font_style => :bold)
  end
  end 
  else
  text "No tables to display"
  end
  text "\n"
  text "\n"
  text "\n"
  text "\n"
  end

  
  #------------------End Type wise Tables Info --------------------------------#

  #----------------- Tables Info --------------------------------------# 
 start_new_page
  text "<b>Tables  info:</b>" ,size: 13,inline_format: true
  text "\n"
      @document.tables.each do |t|

  text "<font size='9'>Table Name:  </font><font size='12'><b>#{t.table_name}</b></font>",inline_format: true
  text "\n"
  text "<font size='9'>Table Type:  </font><font size='12'>#{t.table_type}</font>",inline_format: true
  text "\n"
  text " <font size='9'>Usage:  </font><font size='12'>#{t.description}</font>",inline_format: true
  text "\n"
  text "<font size='9'>#of Rows:  </font><font size='12'>#{number_with_delimiter(t.ofrows)}</font>",inline_format: true
  text "\n"
  all_fields = [["Field","Type", "Size", "Dec", "Usage"]]
  table(all_fields, :header => true, 
  :column_widths => { 0 => 150, 1 => 75, 2 => 75,3 => 50,4=>150}) do
    style(columns(5)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>12
  end
  t.fields.sort_by{ |i| i[:field_name]}.each do |m|
    all_fields1 = [[m.field_name,m.field_type,"#{number_with_delimiter(m.field_size)}","",m.description]]
  table(all_fields1, :header => false,
  :column_widths => { 0 => 150, 1 => 75, 2 => 75,3 => 50,4=>150}) do
    style(columns(4)) {|x| x.align = :center }
  end
  end
  text "\n"
  text "\n" 
  end 

  #----------------- End Tables Info --------------------------------------# 

  #----------------- All Fields Info --------------------------------------# 
 if !@fields.blank? # for fields pdf display
 start_new_page
  text "<b>FIELDS IN DATABASE(All Tables):</b>" ,size: 12,inline_format: true
  text "\n"
  all_tables = [["Field","Type", "Size", "Dec", "Usage", "Table Name"]]
  table(all_tables, :header => true, 
  :column_widths => { 0 => 100, 1 => 50, 2 => 50,3 => 50,4=>150,5=>100}) do
    style(columns(5)) {|x| x.align = :center }
    style row(0), :background_color => "8EB2E2",:size=>12
  end
 @fields = Field.find_all_by_database_name(@document.db_name)
  if @fields.any?
  @fields.sort_by{ |i| i[:field_name]}.each do |f|
    all_tables1 = [[f.field_name,f.field_type,"#{number_with_delimiter(f.field_size)}",f.description,"",f.table_name]]
  table(all_tables1, :header => false,
  :column_widths => { 0 => 100, 1 => 50, 2 => 50,3 => 50,4=>150,5=>100}) do
    style(columns(5)) {|x| x.align = :center }
       end
    end 
  end 
  end # end fields pdf display
#  @document.tables.each do |d|
#  d.fields.sort_by{ |i| i[:field_name]}.each do |f|
#    all_tables1 = [[f.field_name,f.field_type,f.field_size,f.description,"",d.table_name]]
#  table(all_tables1, :header => false,
#  :column_widths => { 0 => 100, 1 => 50, 2 => 50,3 => 50,4=>150,5=>100}) do
#    style(columns(5)) {|x| x.align = :center }
#  end
#  end 
#  end 

  #----------------- End All Fields Info --------------------------------------#
  #----------------- All Sample Records Info --------------------------------------#
  if !@data.blank? #for sample records display
 	start_new_page(:page_layout=>:landscape) 
  text "\n"

  text "<b>All Tables Sample Records:</b>" ,size: 13,inline_format: true
  text "\n"
  @document.tables.each do |t|
  text "<font size='12'>Table Name:  </font><font size='12'><b>#{t.table_name}</b></font>",inline_format: true
  text "\n"
  tab_columns = t.column_type.to_s if t.column_type
  tab_columns = tab_columns.split(",")
  tab_columns = tab_columns.each_slice(6).to_a
  all_sample_records = [tab_columns[0]]
  rec_values = t.records
  if !rec_values.blank?
  table(all_sample_records, :header => true, 
  :column_widths => { 0 => 50, 1 => 80, 2 => 80,3 => 80,4=>110, 5=>100}) do
    style(columns(5)) {|x| x.align = :center}
    style row(0), :background_color => "8EB2E2",:size=>11
  end
  rec_values.each do |v|
  v1 = v.record.to_s
  v1 = v1.split(",")
  v1 = v1.each_slice(6).to_a
  v1[0] = v1[0].map!{ |element| element.gsub("/nil/", '') }
  all_sample_vals = [v1[0]]

  table(all_sample_vals, 
  :column_widths => { 0 => 50, 1 => 80, 2 => 80,3 => 80,4=>110, 5=>100}) do
    style(columns(5)) {|x| x.align = :center}
   end
  end 
  else
  text "No sample records to display"
  text "\n"
  text "\n" 
  end 
	  text "\n"
	  text "\n" 
	  text "\n"
	  text "\n"  
	  text "\n"
	  text "\n" 
	  text "\n"

  end 
  end # for sample data loop
  #----------------- End Sample Records Info --------------------------------------# 
  end 

end
