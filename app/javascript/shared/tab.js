jQuery(function(){
  jQuery('.tab li').on('click',function(){
    jQuery('.tab li').removeClass("active");
    jQuery(this).addClass("active");
    var id=jQuery(this).attr('id');
    jQuery('.tab_cnt div').removeClass("active");
    jQuery('#'+id+'_cnt').addClass("active");
  });
});
