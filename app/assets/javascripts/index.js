var index;
index  = function() {
  var input_type = window.location.pathname;
  if(input_type !== "/terms" && input_type !== "/policy") {
    openSignModal();
  }
  function openSignModal() {
    $("#modal-sign-in").modal();
    $('.modal-content #sign-in').css('display', 'block');
    $('.modal-content #sign-up').css('display', 'none');
  }
}

$(document).on('turbolinks:load', index);
