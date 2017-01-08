$(document).ready(function() {
  $('.modal-content .sign-up-btn').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'block');
    $('.modal-content #sign-up-sub').css('display', 'none');
  });

  $('.modal-content .btn-next').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'none');
    $('.modal-content #sign-up-sub').css('display', 'block');
  });

  $('.modal-content .btn-confirm').on('click', function() {
    signUpProcess();
  });
  // $('#modal-sign-in').on('hidden.bs.modal', function () {
  //   $('.modal-content #sign-in').css('display', 'block');
  //   $('.modal-content #sign-up').css('display', 'none');
  // });
  //
  function signUpProcess() {
    //ajax request
    //if success, close modal
    //if fail, stay in this modal and request again
  }
});
