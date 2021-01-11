$(document).on('turbolinks:load', function(){
  $("#user_picture").on('change', function(){
    $('#avatar_edit').submit();
  });
});
