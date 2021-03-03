$(window).on('turbolinks:load', function() {
  var ELEMENT = $('.calendar').get(0);
  var scrollWidth = ELEMENT.scrollWidth;
  var elementWidth = ELEMENT.clientWidth;
  // 取得した要素の位置を引数に指定
  $('.calendar').scrollLeft(scrollWidth/2-elementWidth/2);
});
