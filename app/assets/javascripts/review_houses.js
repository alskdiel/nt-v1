var review_houses_function = function() {

  // index functions

  // show functions


  // write functions
  var $write_form = $('.write-container').find('.content-wrapper');
  setDuration();

  var price_satisfaction;
  var residence_satisfaction;
  var environment_satisfaction;

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
    $('.write-container').find('#form-write').submit();
  });

  function setDuration() {
    var $s_year = $write_form.find('.duration').find('.duration-start').find('.years');
    var $e_year = $write_form.find('.duration').find('.duration-end').find('.years');
    var $s_month = $write_form.find('.duration').find('.duration-start').find('.months');
    var $e_month = $write_form.find('.duration').find('.duration-end').find('.months');

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
    var start_year = $write_form.find('.duration').find('.duration-start').find('.years').val();
    var start_month = $write_form.find('.duration').find('.duration-start').find('.months').val();
    $start.val(start_year+"-"+start_month+"-1");

    var end_year = $write_form.find('.duration').find('.duration-end').find('.years').val();
    var end_month = $write_form.find('.duration').find('.duration-end').find('.months').val();
    $end.val(end_year+"-"+end_month+"-1");
  }

  function setSatisfactionData($price, $residence, $environment) {
    $price.val(price_satisfaction);
    $residence.val(residence_satisfaction);
    $environment.val(environment_satisfaction);
  }

}

$(document).on('turbolinks:load', review_houses_function);
