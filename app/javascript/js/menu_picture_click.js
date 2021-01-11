$(document).on('turbolinks:load',function(){
  $('#menu_picture').on('click', function() {
    $('#preview').addClass("non-active");
    $('#form-menu-img').removeClass("non-active");
    $('#delete-image').removeClass("non-active");
    $('#message-with-picture').addClass("non-active");
  });
});
