$(document).on('turbolinks:load',function(){
  $('.tab li').on('click',function(){
    $('.tab li').removeClass("active");
    $(this).addClass("active");
    var id=$(this).attr('id');
    $('.tab_cnt div').removeClass("active");
    $('#'+id+'_cnt').addClass("active");
  });
});
