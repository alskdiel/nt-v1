var notice_function = function () {
  var $container = $('.notice-container');

  var $content_tr = $container.find('.notice-wrapper').find('.noti-body').find('table').find('tbody').find('.noti-component-title');
  // console.log($content_tr);

  $content_tr.on('click', function() {
    console.log($(this));
    var $content_tr = $(this).parent().find('.noti-component-content');
    if($content_tr.hasClass('hide')) {
      $content_tr.removeClass('hide');
    } else {
      $content_tr.addClass('hide');
    }
  });
}

$(document).on('turbolinks:load', notice_function);
