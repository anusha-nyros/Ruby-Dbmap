$().ready(function() {  
$('.dbexpand , .dbcollapse img').click(function(e){
    e.preventDefault();

    if ($(this).hasClass('dbexpand')){$(this).toggleClass('dbexpand ,dbcollapse');
        $(this).html('<img src="/assets/colp.png"title="Collapse Table fields" />');
	$('.'+$(this).attr("id")).css("display","");
        $('#browser'+$(this).attr("id")).treeview({
		persist: "location",
		collapsed: true,
		unique: true
	}).find('div.hitarea:first').click();
 	$('#browser1'+$(this).attr("id")).treeview({
		persist: "location",
		collapsed: true,
		unique: true
	}).find('div.hitarea:first').click();
         	$('#browser2'+$(this).attr("id")).treeview({
		persist: "location",
		collapsed: true,
		unique: true
	}).find('div.hitarea:first').click();
    }
    else{
          $(this).toggleClass('dbexpand');  
        $(this).html('<img src="/assets/exp.png" title="Expand Table fields" />');
	$('.'+$(this).attr("id")).css("display","none");
        }
  });

  $('#show_type').change(function () {

    if ($(this).attr("checked")) 
    {
        
        $('#type_tree').css("display","");
        $('#alpha_tree').css("display","none");
        $('#mod_feature_tree').css("display","none");
        return;
    }
   else{
        $('#mod_feature_tree').css("display","none");
        $('#type_tree').css("display","none");
        $('#alpha_tree').css("display","");
   }
   });
  $('#mod_feature').change(function () {
    if ($(this).attr("checked")) 
    {

        $('#type_tree').css("display","none");
        $('#alpha_tree').css("display","none");
        $('#mod_feature_tree').css("display","");
        return;
    }
   else{
        $('#mod_feature_tree').css("display","none");
        $('#type_tree').css("display","none");
        $('#alpha_tree').css("display","");
   }
   });

    $("input[name='theme']").change(function() {
            var c = $("input[name='theme']:checked").val();
            if (c == 'type_tree')
		{
                       $('#type_tree'+$(this).attr("id")).css("display","");
        		$('#alpha_tree'+$(this).attr("id")).css("display","none");
        		$('#mod_feature_tree'+$(this).attr("id")).css("display","none");
		}
            if (c == 'alpha_tree')
		{
                       $('#type_tree'+$(this).attr("id")).css("display","none");
        		$('#alpha_tree'+$(this).attr("id")).css("display","");
        		$('#mod_feature_tree'+$(this).attr("id")).css("display","none");
		}
            if (c == 'mod_feature_tree')
		{
                       $('#type_tree'+$(this).attr("id")).css("display","none");
        		$('#alpha_tree'+$(this).attr("id")).css("display","none");
        		$('#mod_feature_tree'+$(this).attr("id")).css("display","");
		}
            
        });
    $("input[name='theme_active']").change(function() {
            var d = $("input[name='theme_active']:checked").val();
            if (d == 'show_active')
		{
                       $('.in_active_tables'+$(this).attr("id")).css("display","none");
        		           if ($("input[name='theme_count']:checked").val() == "show_count")
                         {
                       $('.tab_cnt1'+$(this).attr("id")).css("display","none");
                       $('.tab_cnt_active'+$(this).attr("id")).css("display","");
                         }
                       else
                       {
                       $('.tab_cnt1'+$(this).attr("id")).css("display","none");
                       $('.tab_cnt_active'+$(this).attr("id")).css("display","none");
                       }
                      
		}
            else
		{
                       $('.in_active_tables'+$(this).attr("id")).css("display","");
                       $('.active_tables'+$(this).attr("id")).css("display","");	
							if ($("input[name='theme_count']:checked").val() == "show_count")
                         {
                       $('.tab_cnt1'+$(this).attr("id")).css("display","");
                       $('.tab_cnt_active'+$(this).attr("id")).css("display","none");

                         }
                       else
                       {
                       $('.tab_cnt1'+$(this).attr("id")).css("display","none");
                       $('.tab_cnt_active'+$(this).attr("id")).css("display","none");

                       }

	
		}

        });
    $("input[name='theme_desc']").change(function() {
            var e = $("input[name='theme_desc']:checked").val();
            if (e == 'show_desc')
		{
                       $('.desc_tables'+$(this).attr("id")).css("display","");
        		
		}
            else
		{
                       $('.desc_tables'+$(this).attr("id")).css("display","none");
		
		}
        });
    $("input[name='theme1']").change(function() {
            var f = $("input[name='theme1']:checked").val();
            if (f == 'alpha_view')
		{
                       $('.alpha_view').css("display","");
                       $('.mod_view').css("display","none");
                       $('.type_view').css("display","none");
		}
            if (f == 'type_view')
		{
                       $('.alpha_view').css("display","none");
                       $('.mod_view').css("display","none");
                       $('.type_view').css("display","");
		}
            if (f == 'mod_view')
		{
                       $('.alpha_view').css("display","none");
                       $('.mod_view').css("display","");
                       $('.type_view').css("display","none");
		}

        });
    $("input[name='theme_active1']").change(function() {
            var g = $("input[name='theme_active1']:checked").val();
            if (g == 'show_active1')
		{
                       $('.alpha_active_tables').css("display","");
                       $('.mod_view_active_tables').css("display","");
                       $('.type_view_active_tables').css("display","");
                       $('.alpha_in_active_tables').css("display","none");
                       $('.mod_view_in_active_tables').css("display","none");
                       $('.type_view_in_active_tables').css("display","none");
                       $('.ty_act').css("display","none");
        	       $('.ty_act1').css("display",""); 	
		}
            else
		{
                       $('.alpha_active_tables').css("display","none");
                       $('.mod_view_active_tables').css("display","none");
                       $('.type_view_active_tables').css("display","none");
                       $('.alpha_in_active_tables').css("display","");
                       $('.mod_view_in_active_tables').css("display","");
                       $('.type_view_in_active_tables').css("display","");
                       $('.ty_act').css("display","");
        	       $('.ty_act1').css("display","none");
        		
		
		}
        });

    $("input[name='theme_count']").change(function() {
 
            var h = $("input[name='theme_count']:checked").val();
            if (h == 'show_count')
		{
                       $('.tab_cnt'+$(this).attr("id")).css("display","");
                       $('.tab_cnt1'+$(this).attr("id")).css("display","");
       		           if ($("input[name='theme_active']:checked").val() == "show_active")
                         {
                       $('.tab_cnt1'+$(this).attr("id")).css("display","none");
                       $('.tab_cnt_active'+$(this).attr("id")).css("display","");
                         }
                       else
                       {
                       $('.tab_cnt'+$(this).attr("id")).css("display","");
                       $('.tab_cnt1'+$(this).attr("id")).css("display","");
                       }

        		
		}
            else
		{
                       $('.tab_cnt'+$(this).attr("id")).css("display","none");
                       $('.tab_cnt1'+$(this).attr("id")).css("display","none");
                       $('.tab_cnt_active'+$(this).attr("id")).css("display","none");

		}

        });




  });
