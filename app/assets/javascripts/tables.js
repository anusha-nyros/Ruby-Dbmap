$().ready(function() {  
$('.expand , .collapse img').click(function(e){
    e.preventDefault();
    if ($(this).hasClass('expand')){$(this).toggleClass('expand ,collapse');
        $(this).html('<img src="/assets/colp.png"title="Collapse Table fields" />');
	$('.'+$(this).attr("id")).css("display","");
    }
    else{
          $(this).toggleClass('expand');  
        $(this).html('<img src="/assets/exp.png" title="Expand Table fields" />');
	$('.'+$(this).attr("id")).css("display","none");
        }
  });
  });

