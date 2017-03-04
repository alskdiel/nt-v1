var index;
index  = function() {
  openSignModal();
  function openSignModal() {
    $("#modal-sign-in").modal();
    $('.modal-content #sign-in').css('display', 'block');
    $('.modal-content #sign-up').css('display', 'none');
  }
}

$(document).on('turbolinks:load', index);
