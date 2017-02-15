var review_houses_function = function() {
  // write functions
  var $write_form = $('.write-container').find('.content-wrapper');
  setDuration();

  var price_satisfaction;
  var residence_satisfaction;
  var environment_satisfaction;

  $('.write-container .content-wrapper .address input').on('focusout', function() {
    var addr = $(this).val();

    var geocoder = new daum.maps.services.Geocoder();

    var callback = function(status, result) {
      if (status === daum.maps.services.Status.OK) {
        console.log(result);
        $('#form-write .content-wrapper .address #latitude').val(result.addr[0].lat);
        $('#form-write .content-wrapper .address #longtitude').val(result.addr[0].lng);
      } else {
        $('#form-write .content-wrapper .address #latitude').val(null);
        $('#form-write .content-wrapper .address #longtitude').val(null);
        alert("위치를 찾을 수 없습니다.");
      }

      console.log($('#form-write .content-wrapper .address #latitude').val());
      console.log($('#form-write .content-wrapper .address #longtitude').val());
    };

    geocoder.addr2coord(addr, callback);
  });

  $('.write-container .content-wrapper .satisfactions .price .stars .score').on('click', function() {
    var $star_container = $(this).parent();
    setStarScore($(this), $star_container, 'price');
  });

  $('.write-container .content-wrapper .satisfactions .residence .stars .score').on('click', function() {
    var $star_container = $(this).parent();
    setStarScore($(this), $star_container, 'residence');
  });

  $('.write-container .content-wrapper .satisfactions .environment .stars .score').on('click', function() {
    var $star_container = $(this).parent();
    setStarScore($(this), $star_container, 'environment');
  });

  $('.write-container .content-wrapper .actions .btn.submit').on('click', function() {
    setFormData();
    var isPossible = checkDataEntered();
    if(isPossible) {
      $('.write-container').find('#form-write').submit();
    }
  });

  function checkDataEntered() {
    // var title = $("input[type='text'][name='review_house[title]']").val() ? true : "제목";
    // var latitude = $("input[type='hidden'][name='latitude']").val() ? true : "주소";
    // var longtitude = $("input[type='hidden'][name='longtitude']").val() ? true : "주소";
    // var address = $("input[type='text'][name='review_house[address]']").val() ? true : "주소";
    // var start_time = $("input[type='hidden'][name='review_house[start_time]']").val() ? true : "거주기간";
    // var end_time = $("input[type='hidden'][name='review_house[end_time]']").val() ? true : "거주기간";
    // var price_satisfaction = $("input[type='hidden'][name='review_house[price_satisfaction]']").val() ? true : "가격만족도";
    // var residence_satisfaction = $("input[type='hidden'][name='review_house[residence_satisfaction]']").val() ? true : "주거지만족도";
    // var env_satisfaction = $("input[type='hidden'][name='review_house[env_satisfaction]']").val() ? true : "주거환경경만족도";
    // var price_review = $("textarea[name='review_house[price_review]']").val().length >= 100 ? true : "가격리뷰";
    // var residence_review = $("textarea[name='review_house[residence_review]']").val().length >= 100 ? true : "주거지리뷰";
    // var env_review = $("textarea[name='review_house[env_review]']").val().length >= 100 ? true : "주거환경리뷰";
    // var cons = $("input[type='text'][name='cons[0]']").val().length > 0 && $("input[type='text'][name='cons[0]']").val().length <= 15 ? true :
    //           ($("input[type='text'][name='cons[1]']").val().length > 0 && $("input[type='text'][name='cons[1]']").val().length <= 15 ? true :
    //           ($("input[type='text'][name='cons[2]']").val().length > 0 && $("input[type='text'][name='cons[2]']").val().length <= 15 ? true : "단점"));
    // var pros = $("input[type='text'][name='pros[0]']").val().length > 0 && $("input[type='text'][name='pros[0]']").val().length <= 15 ? true :
    //           ($("input[type='text'][name='pros[1]']").val().length > 0 && $("input[type='text'][name='pros[1]']").val().length <= 15 ? true :
    //           ($("input[type='text'][name='pros[2]']").val().length > 0 && $("input[type='text'][name='pros[2]']").val().length <= 15 ? true : "장점"));


    var proc = $("input[type='text'][name='review_house[title]']").val() ? true : "제목을";
    if(proc === true) {
      proc = $("input[type='hidden'][name='review_house[latitude]']").val() ? true : "주소를";
      if(proc === true) {
        proc = $("input[type='hidden'][name='review_house[longtitude]']").val() ? true : "주소를";
        if(proc === true) {
          proc = $("input[type='text'][name='review_house[address]']").val() ? true : "주소를";
          if(proc === true) {
            proc = $("input[type='hidden'][name='review_house[start_time]']").val() ? true : "거주기간을";
            if(proc === true) {
              proc = $("input[type='hidden'][name='review_house[end_time]']").val() ? true : "거주기간을";
              if(proc === true) {
                proc = $("input[type='hidden'][name='review_house[price_satisfaction]']").val() ? true : "가격만족도를";
                if(proc === true) {
                  proc = $("input[type='hidden'][name='review_house[residence_satisfaction]']").val() ? true : "주거지만족도를";
                  if(proc === true) {
                    proc = $("input[type='hidden'][name='review_house[env_satisfaction]']").val() ? true : "주거환경경만족도를";
                    if(proc === true) {
                      proc = $("textarea[name='review_house[price_review]']").val().length >= 100 ? true : "가격리뷰를";
                      if(proc === true) {
                        proc = $("textarea[name='review_house[residence_review]']").val().length >= 100 ? true : "주거지리뷰를";
                        if(proc === true) {
                          proc = $("textarea[name='review_house[env_review]']").val().length >= 100 ? true : "주거환경리뷰를";
                          if(proc === true) {
                            proc = $("input[type='text'][name='cons[0]']").val().length > 0 && $("input[type='text'][name='cons[0]']").val().length <= 15 ? true :
                                  ($("input[type='text'][name='cons[1]']").val().length > 0 && $("input[type='text'][name='cons[1]']").val().length <= 15 ? true :
                                  ($("input[type='text'][name='cons[2]']").val().length > 0 && $("input[type='text'][name='cons[2]']").val().length <= 15 ? true : "단점을"));
                            if(proc === true) {
                              proc = $("input[type='text'][name='pros[0]']").val().length > 0 && $("input[type='text'][name='pros[0]']").val().length <= 15 ? true :
                                    ($("input[type='text'][name='pros[1]']").val().length > 0 && $("input[type='text'][name='pros[1]']").val().length <= 15 ? true :
                                    ($("input[type='text'][name='pros[2]']").val().length > 0 && $("input[type='text'][name='pros[2]']").val().length <= 15 ? true : "장점을"));
                              if(proc === true) {
                                return true;
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    alert("올바른 " + proc + " 입력해주세요");
    return false;
  }


  function setDuration() {
    var $s_year = $write_form.find('.duration').find('.duration-start').find('.dur-wrapper').find('.years');
    var $e_year = $write_form.find('.duration').find('.duration-end').find('.dur-wrapper').find('.years');
    var $s_month = $write_form.find('.duration').find('.duration-start').find('.dur-wrapper').find('.months');
    var $e_month = $write_form.find('.duration').find('.duration-end').find('.dur-wrapper').find('.months');

    var today = new Date().getFullYear();
    for(var i=today; i>1899; i--) {
      $s_year.append("<option value="+i+">"+i+"</option>");
      $e_year.append("<option value="+i+">"+i+"</option>");
    }

    var MONTH = 12;
    for(var i=1; i<=MONTH; i++) {
      $s_month.append("<option value="+i+">"+i+"</option>");
      $e_month.append("<option value="+i+">"+i+"</option>");
    }
  }

  function setStarScore($this, $star_container, type) {
    var score = 0;
    if($this.hasClass('first')) {
      score = 1;
    } else if($this.hasClass('second')) {
      score = 2;
    } else if($this.hasClass('third')) {
      score = 3;
    } else if($this.hasClass('fourth')) {
      score = 4;
    } else if($this.hasClass('fifth')) {
      score = 5;
    }

    if(type === 'price') {
      price_satisfaction = score;
    } else if(type === 'residence') {
      residence_satisfaction = score;
    } else if(type === 'environment') {
      environment_satisfaction = score;
    }

    for(var i=0; i<score; i++) {
      $star_container.find('.score:nth-child('+(i+1)+')').find(':nth-child(1)').addClass('none');
      $star_container.find('.score:nth-child('+(i+1)+')').find(':nth-child(2)').removeClass('none');
    }
    for(var i=score; i<5; i++) {
      $star_container.find('.score:nth-child('+(i+1)+')').find(':nth-child(1)').removeClass('none');
      $star_container.find('.score:nth-child('+(i+1)+')').find(':nth-child(2)').addClass('none');
    }
  }

  function setFormData() {
    var $d_s = $write_form.find('.duration').find('.duration-start').find('#start');
    var $d_e = $write_form.find('.duration').find('.duration-end').find('#end');
    setDurationData($d_s, $d_e);

    var $s_p = $write_form.find('.satisfactions').find('.price').find('#price');
    var $s_r = $write_form.find('.satisfactions').find('.residence').find('#residence');
    var $s_e = $write_form.find('.satisfactions').find('.environment').find('#environment');
    setSatisfactionData($s_p, $s_r, $s_e);
  }

  function setDurationData($start, $end) {
    var start_year = $write_form.find('.duration').find('.duration-start').find('.dur-wrapper').find('.years').val();
    var start_month = $write_form.find('.duration').find('.duration-start').find('.dur-wrapper').find('.months').val();
    $start.val(start_year+"-"+start_month+"-1");

    var end_year = $write_form.find('.duration').find('.duration-end').find('.dur-wrapper').find('.years').val();
    var end_month = $write_form.find('.duration').find('.duration-end').find('.dur-wrapper').find('.months').val();
    $end.val(end_year+"-"+end_month+"-1");
  }

  function setSatisfactionData($price, $residence, $environment) {
    $price.val(price_satisfaction);
    $residence.val(residence_satisfaction);
    $environment.val(environment_satisfaction);
  }

}

$(document).on('turbolinks:load', review_houses_function);
