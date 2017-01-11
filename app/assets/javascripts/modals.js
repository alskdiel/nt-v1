$(document).ready(function() {
  $('.modal-content .content-wrapper .sign-up-btn').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'block');
    // $('.modal-content #sign-up-sub').css('display', 'none');
  });

  $('.modal-content .content-wrapper .btn-next').on('click', function() {
    $('.modal-content #sign-up .sign-up-main').css('display', 'none');
    $('.modal-content #sign-up .sign-up-sub').css('display', 'block');
  });

  $('.modal-content .content-wrapper .btn-confirm').on('click', function() {
    // signUpProcess();
  });

  $('.modal-content .content-wrapper .sign-in-btn').on('click', function() {
    var user_id = $(this).parent().parent().children('.email-container').children('.user-id').val();
    var user_pw = $(this).parent().parent().children('.password-container').children('.user-pw').val();

    signInProcess(user_id, user_pw);
  });

  function signInProcess(user_id, user_pw) {
    params = {
      email: user_id,
      password: user_pw
    }
    $.ajax({
      url: 'users/sign_in',
      type: 'POST',
      dataType: 'json',
      data: params,
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        // success callback
        console.log(data);
        if(data.ret) {
          // login successful
          window.location.reload(true);
        } else {
          alert("wrong info");
          // login failed
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
    //ajax request
    //if success, close modal
    //if fail, stay in this modal and request again
  }
});
