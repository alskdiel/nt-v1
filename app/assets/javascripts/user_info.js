var user_info_function = function () {
  var my_nickname;

  var nick_param = false;
  var isPossibleNick = false;
  var isValidPW = false;
  var isPossiblePW2 = false
  var isPossiblePW3 = false

  init();
  function init() {
    my_nickname = $('.user-info-change-container .user-info-body .nickname-container input').val();
    console.log(my_nickname);
  }

  $('.user-info-change-container .user-info-body .nickname-container input').on('focusin', function() {
    nick_param = true;
    $('#form-user-info .nickname-container input').attr('name', 'user_info[nickname]');
  });


  $('.user-info-change-container .user-info-body .submit-container .submit-btn').on('click', function() {
    if(!nick_param) {
      $('#form-user-info').submit();
    } else {
      if(isPossibleNick) {
        $('#form-user-info').submit();
      } else {
        alert("닉네임을 다시 설정해주세요.");
      }
    }
  });

  $('.user-password-change-container .user-password-body .submit-container .submit-btn').on('click', function() {
    if(isValidPW && isPossiblePW2 && isPossiblePW3) {
      $('#form-user-pw').submit();
    } else {
      alert("비밀번호를 다시 설정해주세요.");
    }
  });

  $('.user-info-change-container .user-info-body .nickname-container input').on('focusout', function() {
    var nickname = $(this).val();
    var $info_box = $(this).parent().children('.nick-conf');

    nickConfProcess(nickname, $info_box);
  });

  $('.user-password-change-container .user-password-body .curpw-container input').on('focusout', function() {
    var cur_pw = $(this).val();
    var $info_box = $(this).parent().children('.cur-pw-conf');

    curPwConfProcess(cur_pw, $info_box);
  })

  $('.user-password-change-container .user-password-body .pw-container input').on('focusout', function() {
    isPossiblePW2 = false
    $info_box = $(this).parent().children('.pw-cond');
    var pw = $(this).parent().children('.password').val();
    var chk = checkPwd(pw);

    if(chk.isPossible) {
      isPossiblePW2 = true
      $info_box.text("");
    } else {
      $info_box.text(chk.msg);
    }
  })

  $('.user-password-change-container .user-password-body .pw-c-container input').on('focusout', function() {
    isPossiblePW3 = false
    var pw = $(this).parent().parent().children('.pw-container').children('.password').val();
    var pw_conf = $(this).parent().children('.password-conf').val();
    $info_box = $(this).parent().children('.pw-conf');

    if(pw == pw_conf) {
      isPossiblePW3 = true
      $info_box.text("");
    } else {
      $info_box.text("비밀번호가 일치하지 않습니다.");
    }
  })

  function nickConfProcess(nickname, $info_box) {
    isPossibleNick = false;
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
          isPossibleNick = true;
          $info_box.text("");
        } else {
            console.log(nickname);
            console.log(my_nickname);
          if(nickname == my_nickname) {
            isPossibleNick = true;
            $info_box.text("");
          } else {
            $info_box.text("중복된 닉네임 입니다.");
          }
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }


  function curPwConfProcess(pw, $info_box) {
    isValidPW = false;
    params = {
      password: pw
    }
    $.ajax({
      url: '/valid_pw',
      type: 'POST',
      dataType: 'json',
      data: params,
      complete: function (jqXHR, textStatus) {
        // callback
      },
      success: function (data, textStatus, jqXHR) {
        if(data.ret) {
          isValidPW = true;
          $info_box.text("");
        } else {
          $info_box.text("정확한 비밀번호가 아닙니다.");
        }
        // success callback
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // error callback
      }
    });
  }

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
}

$(document).on('turbolinks:load', user_info_function);
