$(document).on('turbolinks:load', function(){
  $("#user_picture").change(function(){
    $('#avatar_edit').submit();
  });
});
