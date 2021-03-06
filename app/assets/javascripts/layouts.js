var init;
init  = function() {
  $side_bar_bg = $('.side-bar-background');
  $side_bar = $('.side-bar');

  /**************** 연대 배너 **********************/
  $('.yonsei-banner').on('click', function() {
    var redirectWindow = window.open('http://findahouse.co.kr:3000', '_blank');
        redirectWindow.location;
  });
  /**************** 연대 배너 **********************/



  window.onresize = function(event) {
    var window_size = $(window).width();
    if(window_size < 930) {
      $('.nav-bar .nav-search').addClass('hide');
    } else {
      $('.nav-bar .nav-search').removeClass('hide');
    }
  };

  $side_bar_bg.on('click', function() {
    if($(this).hasClass('sidebar-opened')) {
      closeSidebar();
    }
  });

  $('.nav-bar .logo').on('click', function(){
    window.location.href = "/";
  });

  $('.nav-bar .map').on('click', function(){
    window.location.href = "/review_map";
  });
  // $('.nav-bar .nav-search .search').on('keydown', function(key){
  //   if(key.keyCode == 13) {
  //     alert('aaa');
  //   }
  // });

  $('.sub-navbar .all').on('click', function() {
    window.location.href = "/";
  });

  $('.sub-navbar .house').on('click', function() {
    window.location.href = "/review_houses";
  });

  $('.sub-navbar .life').on('click', function() {
    window.location.href = "/review_lives";
  });

  $('.nav-bar .write').on('click', function(){
    checkUserSignedIn("write");
  });

  $('.nav-bar .menu').on('click', function(){
    openSidebar();
  });

  $('.side-bar .header .cancel').on('click', function(){
    closeSidebar();
  });

  $('.side-bar .body .sign-in').on('click', function(){
    openSignModal();
  });

  $('.side-bar .body .user-info .nickname').on('click', function(){
    window.location.href = "/my_reviews";
  });

  $('.side-bar .body .scrap').on('click', function(){
    checkUserSignedIn("scrap");
  });

  $('.side-bar .body .my-map').on('click', function(){
    alert("준비중 입니다.");
  });

  $('.side-bar .body .followings').on('click', function(){
    alert("준비중 입니다.");
  });

  $('.side-bar .body .followers').on('click', function(){
    alert("준비중 입니다.");
  });

  $('.side-bar .body .user-info .sign-out').on('click', function(){
    signoutProcess();
  });

  $('.side-bar .body .user-info .settings').on('click', function(){
    window.location.href = "/user_info";
  });

  $('.side-bar .body .cs').on('click', function(){
    var $this = $(this)
    var $arrow = $this.find('.arrow');
    if($arrow.hasClass("upper")) {
      $arrow.removeClass("upper");
      $this.addClass("border-bottom");
      $this.parent().find(".cs-detail").css("display", "none");
    } else {
      $arrow.addClass("upper");
      $this.removeClass("border-bottom");
      $this.parent().find(".cs-detail").css("display", "block");
    }
  });

  $('.side-bar .body .cs-detail .noti').on('click', function(){
    window.location.href = "/notice";
  });

  $('.side-bar .body .cs-detail .qna').on('click', function(){
    checkUserSignedIn("qna");
  });

  $('.side-bar .body .cs-detail .terms').on('click', function(){
    window.location.href = "/terms";
  });

  $('.side-bar .body .cs-detail .policy').on('click', function(){
    window.location.href = "/policy";
  });

  function checkUserSignedIn(type) {
    $.ajax({
      url: '/users/user_signed_in',
      type: 'get',
      dataType: 'json',
      // data: $.param( $('Element or Expression') ),
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        if(data.user_signed_in) {
          if(type === "scrap") {
            window.location.href = "/my_scraps";
          } else if(type === "write") {
            openWriteModal();
          } else if(type === "qna") {
            window.location.href = "/qna";
          }
        } else {
          alert("로그인 해주세요.");
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }

  function openWriteModal() {
    $("#modal-write").modal();
  }

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
      url: '/users/sign_out',
      type: 'DELETE',
      dataType: 'json',
      // data: $.param( $('Element or Expression') ),
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        if(data.ret) {
          window.location.href = "/";
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }
}

$(document).on('turbolinks:load', init);

