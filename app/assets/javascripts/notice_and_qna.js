var noti_qna_function = function () {
  var $noti_container = $('.notice-container');
  var $qna_container = $('.qna-container');

  var $noti_content_tr = $noti_container.find('.notice-wrapper').find('.noti-body').find('table').find('tbody').find('.noti-component-title');
  var $qna_content_tr = $qna_container.find('.qna-wrapper').find('.qna-body').find('table').find('tbody').find('.qna-component-title');
  var $submit_button = $qna_container.find('.qna-wrapper').find('.qna-body').find('.reg-qna').find('#form-qna').find('.reg-right').find('.submit-button');

  $noti_content_tr.on('click', function() {
    var $content_tr = $(this).parent().find('.noti-component-content');
    if($content_tr.hasClass('hide')) {
      $content_tr.removeClass('hide');
    } else {
      $content_tr.addClass('hide');
    }
  });

  $qna_content_tr.on('click', function() {
    var $content_tr = $(this).parent().find('.qna-component-content');
    if($content_tr.hasClass('hide')) {
      $content_tr.removeClass('hide');
    } else {
      $content_tr.addClass('hide');
    }
  });

  $submit_button.on('click', function() {
    var $container = $(this).parent().parent().find('.reg-left');
    var title = $container.find('input').val();
    var question = $container.find('textarea').val();

    console.log(title)
    console.log(question)
    if(title && question) {
      $container.parent().submit();
    }

  });

}

$(document).on('turbolinks:load', noti_qna_function);
