// sign_in, sign_up modal
$(document).ready(function() {
  // sign-up button in sign-in modal
  $('.modal-content .content-wrapper .sign-up-btn').on('click', function() {
    $('.modal-content #sign-in').css('display', 'none');
    $('.modal-content #sign-up').css('display', 'block');

    $('.modal-content #sign-up .sign-up-main').css('display', 'block');
    $('.modal-content #sign-up .sign-up-sub').css('display', 'none');
    // $('.modal-content #sign-up-sub').css('display', 'none');
  });

  $('.modal-content .content-wrapper .btn-next').on('click', function() {
    if(isPossibleToUserInfo_email && isPossibleToUserInfo_pw) {
      $('.modal-content #sign-up .sign-up-main').css('display', 'none');
      $('.modal-content #sign-up .sign-up-sub').css('display', 'block');

      setBirthYears();
    } else {
      if(!isPossibleToUserInfo_pw) {
        alert('비밀번호를 확인하세요.');
      }
    }
  });

  // sign-up confirm button
  $('.modal-content #sign-up .content-wrapper .btn-confirm').on('click', function() {
    var email = $(this).parent().parent().children('.sign-up-main').children('.email-container').children('.email').val();
    var password = $(this).parent().parent().children('.sign-up-main').children('.password-container').children('.password-conf').val();
    var nickname = $(this).parent().children('.nickname-container').children('.nickname').val();
    var birth = $('#sign-up .sign-up-sub .birth-container .birth option:selected').val();
    var occupation = $('#sign-up .sign-up-sub .occupation-container .occupation option:selected').val();
    var sex = $("#sign-up .sign-up-sub .sex-container input:radio[name='sex']").val();

    // console.log(email+"/"+password+"/"+nickname+"/"+birth+'/'+occupation+"/"+sex);
    signUpProcess(email, password, nickname, birth, occupation, sex);
  });

  // sign-in button
  $('.modal-content .content-wrapper .sign-in-btn').on('click', function() {
    var user_email = $(this).parent().parent().children('.email-container').children('.user-id').val();
    var user_pw = $(this).parent().parent().children('.password-container').children('.user-pw').val();

    signInProcess(user_email, user_pw);
  });

  $('.modal-content .content-wrapper .email-container input').on('focusout', function() {
    var user_email = $(this).val();
    var $info_box = $(this).parent().children('.email-conf');
    if(user_email.indexOf("@") == -1) {
      isPossibleToUserInfo_email = false;
      $info_box.text("올바른 이메일을 입력해 주세요.")
    } else {
      emailConfProcess(user_email, $info_box);
    }
  });

  $('.modal-content .content-wrapper .nickname-container input').on('focusout', function() {
    var nickname = $(this).val();
    var $info_box = $(this).parent().children('.nick-conf');

    nickConfProcess(nickname, $info_box);
  });

  var isPossibleToUserInfo_email = false;
  var isPossibleToUserInfo_pw = false;
  var isPossibleToUserInfo_nick = false;

  $('.modal-content .content-wrapper .password-container .password-conf').on('focusout', function() {
    isPossibleToUserInfo_pw = false;
    var pw = $(this).parent().children('.password').val();
    var pw_conf = $(this).parent().children('.password-conf').val();
    $info_box = $(this).parent().children('.pw-match');

    if(pw == pw_conf) {
      var chk = checkPwd(pw_conf);
      if(chk.isPossible) {
        isPossibleToUserInfo_pw = true;
        $info_box.text("");
      } else {
        $info_box.text(chk.msg);
      }
    } else {
      $info_box.text("비밀번호가 일치하지 않습니다.");
    }
  });

  function checkPwd(str) {
    if (str.length < 8) {
      return { msg: "too_short",
               isPossible: false };
    } else if (str.length > 16) {
      return { msg: "too_long",
               isPossible: false };
    } else if (str.search(/\d/) == -1) {
      return { msg: "no_num",
               isPossible: false };
    } else if (str.search(/[a-zA-Z]/) == -1) {
      return { msg: "no_letter",
               isPossible: false };
    } else if (str.search(/[^a-zA-Z0-9\!\@\#\$\%\^\&\*\(\)\_\+]/) != -1) {
      return { msg: "bad_char",
               isPossible: false };
    }
    return { msg: "",
             isPossible: true };
  }

  function setBirthYears() {
    $sb = $('#sign-up').find('.sign-up-sub').find('.birth-container').find('.birth');
    var today = new Date().getFullYear();
    for(var i=today; i>1899; i--) {
      $sb.append("<option value="+i+">"+i+"</option>");
    }
  }

  function nickConfProcess(nickname, $info_box) {
    isPossibleToUserInfo_nick = false;
    params = {
      nickname: nickname
    }
    $.ajax({
      url: 'users/confirm_nick',
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
      url: 'users/confirm',
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

  function signInProcess(user_email, user_pw) {
    params = {
      email: user_email,
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
    params = {
      user : { email: email,
               password: password },
      nickname: nickname,
      birth: birth,
      occupation: occupation,
      sex: sex
    };
    $.ajax({
      url: 'users',
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
});
