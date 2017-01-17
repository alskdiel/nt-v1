
var init;
init  = function() {
  $side_bar_bg = $('.side-bar-background');
  $side_bar = $('.side-bar');
  console.log('xx');

  $('.nav-bar .menu').on('click', function(){
  console.log('side-bar');
    openSidebar();
  });

  $('.side-bar .header .cancel').on('click', function(){
    closeSidebar();
  });

  $('.side-bar .body .sign-in').on('click', function(){
    openSignModal();
  });

  $('.side-bar .body .user-info .sign-out').on('click', function(){
    signoutProcess();
  });

  $('.side-bar .followings').on('click', function(){
    $("#modal-test").modal();
  });


  function openSidebar() {
    $side_bar_bg.addClass('sidebar-opened');
    $side_bar.addClass('opened');
  }

  function closeSidebar() {
    $side_bar_bg.removeClass('sidebar-opened');
    $side_bar.removeClass('opened');
  }

  function openSignModal() {
    $("#modal-sign-in").modal();
    $('.modal-content #sign-in').css('display', 'block');
    $('.modal-content #sign-up').css('display', 'none');
  }

  function signoutProcess() {
    $.ajax({
      url: 'users/sign_out',
      type: 'DELETE',
      dataType: 'json',
      // data: $.param( $('Element or Expression') ),
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        console.log(data);
        if(data.ret) {
          window.location.reload(true);
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }
}

// $(document).ready(init);
// $(document).on('page:load', init);
// $(document).on('ready page:partial-load', init);
$(document).on('ready', init);
// $(document).on('turbolinks:change', init);
$(document).on('turbolinks:load', init);

