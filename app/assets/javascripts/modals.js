$(document).ready(function() {
  $('#sign-up-btn').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'block');
  });

  $('#modal-sign-in').on('hidden.bs.modal', function () {
    $('.modal-content #sign-in').css('display', 'block');
    $('.modal-content #sign-up').css('display', 'none');
  });
});
