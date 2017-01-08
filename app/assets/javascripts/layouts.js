$(document).ready(function(){

  $side_bar_bg = $('.side-bar-background');
  $side_bar = $('.side-bar');

  $('.nav-bar .menu').on('click', function(){
    openSidebar();
  });

  $('.side-bar .cancel').on('click', function(){
    closeSidebar();
  });

  $('.side-bar .user-info').on('click', function(){
    openSignModal();
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
    $('.modal-content #sign-up-sub').css('display', 'none');
  }

});
