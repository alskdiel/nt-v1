// sign_in, sign_up modal
var modal_function = function () {
  // sign-up button in sign-in modal
  $('#modal-sign-in .modal-content .content-wrapper .sign-up-btn').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'block');

    $('.modal-content #sign-up .sign-up-main').css('display', 'block');
    $('.modal-content #sign-up .sign-up-sub').css('display', 'none');
    $('.modal-content #sign-up .sign-up-fin').css('display', 'none');
    // $('.modal-content #sign-up-sub').css('display', 'none');
  });

  $('#modal-sign-in .modal-content .content-wrapper .sign-up-btn').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'block');

    $('.modal-content #sign-up .sign-up-main').css('display', 'block');
    $('.modal-content #sign-up .sign-up-sub').css('display', 'none');
    $('.modal-content #sign-up .sign-up-fin').css('display', 'none');
  });

  $('#modal-sign-in .modal-content .content-wrapper .btn-next').on('click', function() {
    if(isPossibleToUserInfo_email && isPossibleToUserInfo_pw) {
      $('.modal-content #sign-up .sign-up-main').css('display', 'none');
      $('.modal-content #sign-up .sign-up-sub').css('display', 'block');
      $('.modal-content #sign-up .sign-up-fin').css('display', 'none');

      setBirthYears();
    } else {
      if(!isPossibleToUserInfo_pw) {
        alert('비밀번호를 확인하세요.');
      }
    }
  });

  // sign-up confirm button
  $('#modal-sign-in .modal-content #sign-up .content-wrapper.sign-up-sub .btn-confirm').on('click', function() {
    var email = $(this).parent().parent().children('.sign-up-main').children('.email-container').children('.email').val();
    var password = $(this).parent().parent().children('.sign-up-main').children('.password-container').children('.password-conf').val();
    var nickname = $(this).parent().children('.nickname-container').children('.nickname').val();
    var birth = $('#sign-up .sign-up-sub .birth-container .birth option:selected').val();
    var occupation = $('#sign-up .sign-up-sub .occupation-container .occupation option:selected').val();
    var sex = $("#sign-up .sign-up-sub .sex-container input:radio[name='sex']:checked").val();
    var $sex = $("#sign-up .sign-up-sub .sex-container input:radio[name='sex']:checked");

    if(email && password && nickname && birth && occupation && $sex.is(":checked")) {
      signUpProcess(email, password, nickname, birth, occupation, sex);
    } else {
      alert("정보를 입력해 주세요.");
    }
  });

  // sign-in button
  $('#modal-sign-in .modal-content .content-wrapper.sign-up-fin .btn-okay').on('click', function() {
    window.location.reload(true);
  });

  $('#modal-sign-in .modal-content #sign-in .content-wrapper .forgot-container .find-pw').on('click', function() {
    $("#modal-sign-in").modal('hide');
    $("#modal-forgot-pw").modal();
  });

  $('#modal-forgot-pw .modal-dialog .modal-content .modal-body .send-email').on('click', function() {
    var email = $(this).parent().children('input').val();

    forgotPassword(email);
  });

  $('#modal-sign-in .modal-content .content-wrapper.sign-in-main .remember-container div').on('click', function() {
    var current_status = $(this).parent().children('.remember-me').is(':checked') ? 1: 0;

    console.log(current_status)
    if(current_status) {
      $(this).parent().children('.remember-me').prop('checked', false);
    } else {
      $(this).parent().children('.remember-me').prop('checked', true);
    }
  });

  $('#modal-sign-in .modal-content .content-wrapper.sign-in-main .password-container input').on('keydown', function(key) {
    if(key.keyCode == 13) {
      var user_email = $(this).parent().parent().children('.email-container').children('.user-id').val();
      var user_pw = $(this).parent().parent().children('.password-container').children('.user-pw').val();
      var remember_me = $(this).parent().parent().children('.remember-container').children('.remember-me').is(':checked') ? 1: 0;

      signInProcess(user_email, user_pw, remember_me);
    }
  });

  $('#modal-sign-in .modal-content .content-wrapper.sign-in-main .sign-in-btn').on('click', function() {
    var user_email = $(this).parent().parent().children('.email-container').children('.user-id').val();
    var user_pw = $(this).parent().parent().children('.password-container').children('.user-pw').val();
    var remember_me = $(this).parent().parent().children('.remember-container').children('.remember-me').is(':checked') ? 1: 0;

    signInProcess(user_email, user_pw, remember_me);
  });

  $('#modal-sign-in .modal-content .content-wrapper.sign-up-main .email-container input').on('focusout', function() {
    var user_email = $(this).val();
    var $info_box = $(this).parent().children('.email-conf');
    if(user_email.indexOf("@") == -1) {
      isPossibleToUserInfo_email = false;
      $info_box.text("올바른 이메일 주소가 아닙니다.");
    } else {
      emailConfProcess(user_email, $info_box);
    }
  });

  $('#modal-sign-in .modal-content .content-wrapper.sign-up-sub .nickname-container input').on('focusout', function() {
    var nickname = $(this).val();
    var $info_box = $(this).parent().children('.nick-conf');

    nickConfProcess(nickname, $info_box);
  });

  var isPossibleToUserInfo_email = false;
  var isPossibleToUserInfo_pw = false;
  var isPossibleToUserInfo_pw2 = false;
  var isPossibleToUserInfo_nick = false;

  $('#modal-sign-in .modal-content .content-wrapper.sign-up-main .password-container .password').on('focusout', function() {
    isPossibleToUserInfo_pw2 = false;
    $info_box = $(this).parent().children('.pw-cond');
    var pw = $(this).parent().children('.password').val();
    var chk = checkPwd(pw);

    if(chk.isPossible) {
      isPossibleToUserInfo_pw2 = true;
      $info_box.text("");
    } else {
      $info_box.text(chk.msg);
    }
  });

  $('#modal-sign-in .modal-content .content-wrapper.sign-up-main .password-container .password-conf').on('focusout', function() {
    isPossibleToUserInfo_pw = false;
    var pw = $(this).parent().children('.password').val();
    var pw_conf = $(this).parent().children('.password-conf').val();
    $info_box = $(this).parent().children('.pw-conf');

    if(pw == pw_conf) {
      isPossibleToUserInfo_pw = true;
      $info_box.text("");
    } else {
      $info_box.text("비밀번호가 일치하지 않습니다.");
    }
  });

  $('#modal-write .modal-dialog .modal-content .modal-title .close-wrapper').on('click', function() {
    $("#modal-write").modal('hide');
  });

  $('#modal-forgot-pw .modal-body.send input').on('keydown', function(key) {
    if(key.keyCode == 13) {
      email = $(this).val();
      forgotPassword(email);
    }
  });

  $('#modal-forgot-pw .modal-body.complete .btn-okay').on('click', function() {
    $('#modal-forgot-pw').modal('hide');
    $('#modal-forgot-pw .modal-body.send').css('display', 'block');
    $('#modal-forgot-pw .modal-body.complete').css('display', 'none');
  });

  $('#modal-forgot-pw').on('hidden.bs.modal', function (){
    $('#modal-forgot-pw .modal-body.send').css('display', 'block');
    $('#modal-forgot-pw .modal-body.complete').css('display', 'none');
  });

  function checkPwd(str) {
    if (str.length < 8) {
      return { msg: "8~16자 영문, 숫자를 혼합해주세요.",
               isPossible: false };
    } else if (str.length > 16) {
      return { msg: "8~16자 영문, 숫자를 혼합해주세요.",
               isPossible: false };
    } else if (str.search(/\d/) == -1) {
      return { msg: "8~16자 영문, 숫자를 혼합해주세요.",
               isPossible: false };
    } else if (str.search(/[a-zA-Z]/) == -1) {
      return { msg: "8~16자 영문, 숫자를 혼합해주세요.",
               isPossible: false };
    } else if (str.search(/[^a-zA-Z0-9\!\@\#\$\%\^\&\*\(\)\_\+]/) != -1) {
      return { msg: "8~16자 영문, 숫자를 혼합해주세요.",
               isPossible: false };
    }
    return { msg: "",
             isPossible: true };
  }

  function setBirthYears() {
    var $sb = $('#sign-up').find('.sign-up-sub').find('.birth-container').find('.birth');
    var today = new Date().getFullYear();
    for(var i=today; i>1899; i--) {
      $sb.append("<option value="+i+">"+i+"</option>");
    }
  }

  function forgotPassword(email) {
    $.ajax({
      url: '/users/password',
      type: 'POST',
      dataType: 'json',
      data: { email: email },
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        console.log(data);
        if(data.ret) {
          $('#modal-forgot-pw .modal-body.send').css('display', 'none');
          $('#modal-forgot-pw .modal-body.complete').css('display', 'block');

          var info_text = email+" 으로 임시 비밀번호가 발송되었습니다. 메일을 확인해주세요.";
          $('#modal-forgot-pw .modal-body.complete .info-box').text(info_text);
        } else {
          $("#modal-forgot-pw .send .email-cond").text("이메일이 존재하지 않습니다.");
          console.log($("#modal-forgot-pw .send .email-cond"))

        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
        alert("메일 전송에 실패했습니다. 잠시 후 다시 시도해 주세요.")
      }
    });
  }

  function nickConfProcess(nickname, $info_box) {
    isPossibleToUserInfo_nick = false;
    params = {
      nickname: nickname
    }
    $.ajax({
      url: '/users/confirm_nick',
      type: 'POST',
      dataType: 'json',
      data: params,
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        if(data.ret) {
          isPossibleToUserInfo_nick = true;
          $info_box.text("사용 가능한 닉네임 입니다.");
        } else {
          $info_box.text("중복 된 닉네임 입니다.");
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }
  function emailConfProcess(user_email, $info_box) {
    isPossibleToUserInfo_email = false;
    params = {
      email: user_email
    }
    $.ajax({
      url: '/users/confirm',
      type: 'POST',
      dataType: 'json',
      data: params,
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        if(data.ret) {
          isPossibleToUserInfo_email = true;
          $info_box.text("사용 가능한 이메일 입니다.");
        } else {
          $info_box.text("가입 된 이메일 입니다.");
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }

  function signInProcess(user_email, user_pw, remember_me) {
    params = {
      user: {
        email: user_email,
        password: user_pw,
        remember_me: remember_me
      }
    }
    $.ajax({
      url: '/users/sign_in',
      type: 'POST',
      dataType: 'json',
      data: params,
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        // success callback
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
  }

  function signUpProcess(email, password, nickname, birth, occupation, sex) {
    var info_text = email+" 으로 이메일이 발송되었습니다. 메일을 확인해주세요.";
    var info_text2 = "스팸메일함도 확인해주세요. ㅠ.ㅠ";
    params = {
      user : { email: email,
               password: password },
      nickname: nickname,
      birth: birth,
      occupation: occupation,
      sex: sex
    };
    $.ajax({
      url: '/users',
      type: 'POST',
      dataType: 'json',
      data: params,
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        // success callback
        if(data.ret) {
          $('.modal-content #sign-up .sign-up-sub').css('display', 'none');
          $('.modal-content #sign-up .sign-up-fin').css('display', 'block');
          $('.modal-content #sign-up .sign-up-fin').find('.info-container').find('.info-text').children('div:first-child').text(info_text);
          $('.modal-content #sign-up .sign-up-fin').find('.info-container').find('.info-text').children('div:nth-child(2)').text(info_text2);

        } else {
          alert("wrong info");
          // login failed
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }

  $('#modal-write .modal-content .modal-body .oneroom').on('click', function() {
    $("#modal-write-info").modal();
  });

  $('#modal-write .modal-content .modal-body .living').on('click', function() {
    $("#modal-write").modal('hide');
    $("#modal-write-lifefeed").modal();
  });

  $('#modal-write-lifefeed').on('hidden.bs.modal', function (){
    $("#modal-write-lifefeed").find('.modal-dialog').find('.modal-content').find('#form-life').find('.modal-body').find('.title').find('input').val('');
    $("#modal-write-lifefeed").find('.modal-dialog').find('.modal-content').find('#form-life').find('.modal-body').find('.hashtag').find('input').val('');
    $("#modal-write-lifefeed").find('.modal-dialog').find('.modal-content').find('#form-life').find('.modal-body').find('.content').find('textarea').val('');
    $("#modal-write-lifefeed").find('.modal-dialog').find('.modal-content').find('#form-life').find('.modal-body').find('.image-file').find('input').val('');
    $("#modal-write-lifefeed").find('.modal-dialog').find('.modal-content').find('#form-life').find('.modal-body').find('.image-file').find('.image-path').text('');
    $("#modal-write-lifefeed").find('.modal-dialog').find('.modal-content').find('#form-life').attr('action', '/review_lifes');
  });

  $('#modal-write-info .modal-content .modal-footer .button-wrapper .btn.agree').on('click', function() {
    window.location.href = "/review_houses/new";
  });

  $('#modal-write-info .modal-content .modal-footer .button-wrapper .btn.disagree').on('click', function() {
    $("#modal-write").modal('hide');
    $("#modal-write-info").modal('hide');
  });

  $('#modal-write-lifefeed .modal-content .modal-body .image-file #write-life-img').on('change', function() {
    var file_path = $(this).val();
    file_path = file_path.substring(file_path.indexOf('\\fakepath\\') + 10, file_path.length);
    $(this).parent().find('.image-path').text(file_path);
  });

  $('#modal-write-lifefeed .modal-content .modal-footer .submit').on('click', function() {
    var $form = $(this).parent().parent();
    var title = $form.children('.modal-body').children('.title').children('input').val();
    var content = $form.children('.modal-body').children('.content').children('textarea').val();
    if(!title) {
      alert("제목을 입력해주세요.");
    } else {
      if(!content) {
        alert("내용을 입력해주세요.");
      } else {
        $form.submit();
      }
    }
  });
}

$(document).on('turbolinks:load', modal_function);
