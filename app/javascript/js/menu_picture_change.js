$(document).on('turbolinks:load',function(){
  $('#menu_picture').on('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 7) {
      alert('最大ファイルサイズは7MBです。');
    }

    $('#form-menu-img').addClass("non-active");
    $('#delete-image').addClass("non-active");
    $('#preview').removeClass("non-active");
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#preview').attr('src', e.target.result);
    }
    reader.readAsDataURL(file);
    $('#message-with-picture').removeClass("non-active");
    $('#message-with-picture').addClass("active");
  });
});
