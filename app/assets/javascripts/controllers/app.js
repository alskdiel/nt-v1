var myApp = angular.module('myApp', ['ui.bootstrap', 'wu.masonry']);

myApp.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

myApp.controller('NavCtrl', [
  '$scope',
  '$http',

  function($scope, $http) {
    var search_type = 'house';
    $scope.search_keywords;

    $scope.setSearchType = function($event, type) {
      $scope.search_keywords = "";
      var $type_wrapper = angular.element($event.currentTarget).parent();
      if(type === 'house') {
        $type_wrapper.find('.life').removeClass('selected');
        $type_wrapper.find('.house').addClass('selected');
        $type_wrapper.parent().find('.search-input-wrapper').find('.search').attr('placeholder', 'search');
      } else {
        $type_wrapper.find('.house').removeClass('selected');
        $type_wrapper.find('.life').addClass('selected');
        $type_wrapper.parent().find('.search-input-wrapper').find('.search').attr('placeholder', '#내집#탐방#좋아요');
      }
      search_type = type;
    }

    $scope.search = function() {
      var params_str;
      if(search_type === 'house') {
        params_str = searchHouse($scope.search_keywords);
      } else {
        params_str = searchLife($scope.search_keywords);
      }

      var uri = "/search/"+params_str;
      encodeURI(uri);
      window.location.href = uri;
    }

    function searchHouse(keywords) {
      var params_str = $scope.search_keywords;
      params_str = params_str.toLowerCase();
      params_str = params_str.replace(" ", "&");
      params_str = 'house?='+params_str;

      return params_str;
    }

    function searchLife(keywords) {
      var keywords_str = $scope.search_keywords;
      keywords_str = keywords_str.toLowerCase();
      keywords_str = keywords_str.replace(" ", "");
      var params = keywords_str.split("#");
      var params_str = params.join("&");
      params_str = 'life?='+params_str.substr(1, params_str.length);

      return params_str;
    }
}

]);

myApp.controller('MainCtrl', [
  '$scope',
  '$http',


  function($scope, $http) {
    $scope.my_info = {};


    $scope.uploadImage = function() {
      $('#form-cover-img').submit();
    }

    $scope.getHotReviews = function() {
      alert("hot");
    }

    $scope.getNewReviews = function() {
      alert("new");
    }

    $scope.getBestReviews = function() {
      alert("best");
    }

    initController();

    function initController() {
      var input_type = window.location.pathname;

      if(input_type === "/my_reviews") {
        getMyReviewInfo();
      } else {
        var input = input_type.split("/");
        var from = input[1];
        var review_id = input[2];
        if(from === "user_reviews_h") {
          getUserReviewInfo_H(review_id);
        } else if(from === "user_reviews_l") {
          getUserReviewInfo_L(review_id);
        }
      }

    }

    function getMyReviewInfo() {
      $http({
        method: 'get',
        url: '/get_my_review_info.json'
      })
        .then(function(data, status, headers, config) {
          if(data.data.ret) {
            $scope.my_info = data.data.my_info;
            $scope.is_mypage = data.data.is_mypage;
          } else {
            alert("user not accessible");
          }
        });
    }

    function getUserReviewInfo_H(id) {
      var url = '/get_user_review_info_H/' + id + '.json'
      $http({
        method: 'get',
        url: url
      })
        .then(function(data, status, headers, config) {
          if(data.data.ret) {
            $scope.my_info = data.data.my_info;
            $scope.is_mypage = data.data.is_mypage;
          } else {
            alert("user not accessible");
          }
        });
    }

    function getUserReviewInfo_L(id) {
      var url = '/get_user_review_info_L/' + id + '.json'
      $http({
        method: 'get',
        url: url
      })
        .then(function(data, status, headers, config) {
          if(data.data.ret) {
            $scope.my_info = data.data.my_info;
            $scope.is_mypage = data.data.is_mypage;
          } else {
            alert("user not accessible");
          }
        });
    }


  }
]);


myApp.controller('MapCtrl', [
  '$scope',
  '$http',

  function($scope, $http) {
    console.log("mapctrl");
    var container = document.getElementById('map');
    var map;
    var options;
    var bounds;

    initMapCtrl();

    function initMapCtrl() {
      var my_position = {
        latitude: 33.583231,
        longtitude: 126.900171,
        level: 6
      };

      navigator.geolocation.getCurrentPosition(function(position) {
        my_position.latitude = position.coords.latitude;
        my_position.longtitude = position.coords.longitude;
        my_position.level = 4;
        initMap(my_position);
      });
    }

    function initMap(my_position) {
      options = {
        center: new daum.maps.LatLng(my_position.latitude, my_position.longtitude),
        level: my_position.level
      };

      map = new daum.maps.Map(container, options);
      resizeMap();
      bounds = map.getBounds();
      console.log(bounds);



      daum.maps.event.addListener(map, 'bounds_changed', function() {
        bounds = map.getBounds();
        console.log(bounds);
      });


      // tt();

    }

    var addr = ["서울시 마포구 망원동 479-94","경기도 고양시 덕양구 행신동 760-1","서울시 마포구 광성로4길 22-11","서울시 은평구 신사동 21-12","서울시 은평구 역촌동 대지빌딩","서울시 마포구 망원동 418-27","서울특별시 서대문구 13-49","서울시 서대문구 창천동 502-22","서울시 마포구 효창목길23","서울시 마포구 숭문16가길 26","서울시 마포구 서교동 474-15","경기 고양 덕양구 행신동 송악모노빌","서울시 서대문구 연희동 136-14","경기도 고양시 덕양구 행신동 743-8","서울시 마포구 서교동 343-22","서울시 마포구 서교동 473-17","서울시 마포구 망원로 2길 36","경기도 고양시 덕양구 화전동 575-11 글로벌시티","경기도 고양시 덕양구 행신동 지엘리치빌","경기도 고양시 덕양구 152번길 9","경기도 고양시 덕양구 송악모노빌","경기도 고양시 덕양구 행신동 722-8","서울시 서대문구 연희동 107-4","서울시 마포구 신수동 창천로 2길 37","서울시 서대문구 연희동 309-10","경기도 고양시 덕양구 화전동 중앙로 192번지","경기도 고양시 행신동 대흥프라자","경기도 고양시 덕양구 현천동 184-1","경기도 고양시 덕양구 행신동 756-3","경기도 고양시 덕양구 203-28번지","서울특별시 서대문구 홍은동 346-13","서울시 마포구 연남동 226-34","서울특별시 서대문구 남가좌동 5-150 드림캐슬3호점","서울시 은평구 응암동 755-33","서울특별시 서대문구 남가좌2동 9-57","서울시 서대운구 홍은동 408-14","서울시 서대문구 신촌로 119","서울시 서대문구 신촌로 7길 50-25","경기도 고양시 덕양구 용현로21 (송악모노빌)","경기도 고양시 덕양구 화전동 중앙로 152번길 20-5","서울시 마포구 노고산동 르메이에르타운1차","서울시 은평구 응암동 270-67번지","서울특별시 서대문구 홍은2동 325-8 번지","서울시 서대문구 홍은동 400-42","서울특별시 마포구 서교동 와우산로 162- 2","서울시 마포구 대흥동 22-3","서울시 마포구 신수동 93-31","서울시 마포구 광성로 4길 18-4","서울특별시 마포구 대흥동 174","서울시 마포구 노고산동 54-37","서울시 마포구 상암동 한화오벨리스크 2차","서울시 서대문구 창천동 29-43","서울시 마포구 노고산동 백범로 8","서울시 마포구 대흥동 22-44번지","서울시 마포구 대흥동 12-41 서희스타힐스","서울시 마포구 상수동 88-9","서울시 마포구 백범로 10","서울시 서대문구 신촌로 121","서울시 서대문구 창천동 르메이에르타운5","서울시 마포구 신수동 85-15","서울시 마포구 대흥동 34-2","서울시 마포구 노고산동 신촌포스빌","서울시 서대문구 홍은2동 406-3","서울시 서대문구 남가좌동 9-1","서울시 마포구 신수도 89-14","서울시 서대문구 신촌로 189","서울시 서대문구 창천동 90-49번지","서울시 마포구 노고산동","서울시 마포구 망원동 130-6","서대문구 이화여대 2길 4","서울시 서대문구 대신동 127-17","서울시 서대문구 합동 117","서울시 마포구","서울시 마포구 망원2동 424-6번지","서울시 동대문구 이문로86","서울시 은평구 응암동 111-44","서울시 서대문구 대현동 신촌자이엘라","서울시 대학동 251-446","서울시 마포구 망원동 471-33","서울시 마포구 망원1동","서울 구로구 오류동27-32","서울시 마포구 망원동 374-3","서울시 은평구 서오릉로 35","서울시 노원구 공릉동 683-14 한일휴니스빌","서울시 흑석동 204-27","서울시 서대문구 연희로 8길 28-9","서울시 금천구 독산동 149-28","서울시 서대문구 남가좌동 12-3","서울시 강서구 마곡서1로 115-1 헤리움 1차","서울시 마포구 동교동 149-10","서울시 구로구 공원로 11 대림역 포스큐","서울시 마포구 염리동 9-89","서울시 강서구 아너스빌","서울시 서대문구 남가좌동 12-3","서울시 은평구 응암동 117-42","서울시 서대문구 남가좌동 33-45","서울시 은평구 통일로67길 9","서울시 금천구 독산3동 990-7번지","서울시 마포구 성산동 251-20 대명풀하우스","서울시 서대문구 홍은동 398-2 빌레드유니","경기도 고양시 덕양구 행신동 1093-7","서울시 금천구 독산동 149-28","서울시 서대문구 홍은동 325-8","서울시 서대문구 남가좌동 324-27","경기도 고양시 덕양구 현천동 183","서울시 은평구 신사동 1-72번지","서울시 서대문구 북가좌동 366-25"];
    console.log(addr);
    function tt() {
      var geocoder = new daum.maps.services.Geocoder();

      var callback = function(status, result) {
        if (status === daum.maps.services.Status.OK) {
          console.log(result);
        } else {
          console.log('not found');
        }
      };

      for(var i=0; i<addr.length; i++){
        geocoder.addr2coord(addr[i], callback);
      }
    }
    // bound changed


    function resizeMap() {
      $('.main-container').css('height', '100%');
      var mapContainer = document.getElementById('map');
      var mapWrapper = document.getElementById('map-wrapper');
      var width = getComputedStyle(mapWrapper).width;
      var height = getComputedStyle(mapWrapper).height;

      mapContainer.style.width = width;
      mapContainer.style.height = height;
      relayout();
    }

    function relayout() {
      map.relayout();
    }

  }
]);

myApp.controller('PinCtrl', [
  '$scope',
  '$http',
  '$timeout',
  '$uibModal',

  function($scope, $http, $timeout, $uibModal) {
    $scope.reviews = [];

    initController();

    $scope.getCardDetail = function(review) {
      if(review.is_house_review) {
        getCardDetail_house(review.id);
      } else {
        getCardDetail_life(review.id);
      }
    }

    function getCardDetail_house(id) {
      var url = "/review_houses/"+id+".json";
      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          var modalInstance = $uibModal.open({
            windowClass: 'modal-dialog-show',
            controller: 'ShowCtrl',
            templateUrl: 'showModal.html',
            resolve: {
              data: data.data
            }
          });
        });
    }

    function getCardDetail_life(id) {
      var url = "/review_lives/"+id+".json";
      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          var modalInstance = $uibModal.open({
            windowClass: 'modal-dialog-show-life',
            controller: 'ShowLifeCtrl',
            templateUrl: 'showLifeModal.html',
            resolve: {
              data: data.data
            }
          });
        });
    }

    function initController() {
      var input_type = decodeURI(window.location.pathname);
      if(input_type === "/") {
        getAllReviews();
      } else if(input_type === "/review_houses") {
        getOneroomReviews();
      } else if(input_type === "/review_lives") {
        getLifeReviews();
      } else if(input_type === "/my_reviews") {
        getMyReviews();
      } else if(input_type === "/my_scraps") {
        getMyScraps();
      } else {
        var input = input_type.split("/");
        console.log(input_type)
        console.log(input);
        var from = input[1];
        if(from === "search") {
          var type = input[2];
          var params_str = decodeURI(window.location.search);
          params_str = params_str.substring(2, params_str.length);

          getSearchedReviews(type, params_str);
        } else {
          var review_id = input[2];
          if(from === "user_reviews_h") {
            getUserReviews_H(review_id);
          } else if(from === "user_reviews_l"){
            getUserReviews_L(review_id);
          }
        }
      }
    }

    function getAllReviews() {
      $http({
        method: 'get',
        url: '/get_reviews.json'
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data;
        });
    }

    function getOneroomReviews() {
      $http({
        method: 'get',
        url: '/get_house_reviews.json'
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data;
        });
    }

    function getLifeReviews() {
      $http({
        method: 'get',
        url: '/get_life_reviews.json'
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data;
        });
    }

    function getMyReviews() {
      $http({
        method: 'get',
        url: '/get_my_reviews.json'
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data.reviews;
        });
    }

    function getMyScraps() {
      $http({
        method: 'get',
        url: '/get_my_scraps.json'
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data.reviews;
        });
    }

    function getUserReviews_H(id) {
      var url = '/get_user_reviews_H/' + id + '.json'
      $http({
        method: 'get',
        url: url
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data.reviews;
        });
    }

    function getUserReviews_L(id) {
      var url = '/get_user_reviews_L/' + id + '.json'
      $http({
        method: 'get',
        url: url
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data.reviews;
        });
    }

    function getSearchedReviews(type, params) {
      data = {
        type: type,
        params: params
      }
      $http({
        method: 'post',
        url: '/get_searched_reviews.json',
        data: data
      })
        .then(function(data, status, headers, config) {
          $scope.reviews = data.data;
        });
    }
  }

]);


myApp.controller('ShowCtrl', [
  '$scope',
  '$http',
  '$timeout',
  '$uibModalInstance',
  'data',

  function($scope, $http, $timeout, $uibModalInstance, data) {

    // var ROOT_PATH = "http://localhost:3000/"
    var current_img_tab;
    var sort_by = 'hot';
    $scope.image_url = data.image_url;

    $scope.id = data.id;
    $scope.title = data.title;
    $scope.written_by = data.written_by;
    $scope.address = data.address;
    $scope.duration = data.duration;
    $scope.satisfaction = data.satisfaction;
    $scope.reviews = data.reviews;
    $scope.pros_and_cons = data.pros_and_cons;
    $scope.upvote_and_scrap = data.upvote_and_scrap;
    $scope.comments = [];

    $scope.comment_writting = "";

    $timeout(function() {
      setStarScore(data.satisfaction);
      getComments();
      initImagePath();
    });

    $scope.to_prev_image = function() {
      if(current_img_tab === 0) {
        current_img_tab = $scope.image_url.length - 1;
      } else {
        current_img_tab--;
      }
      $scope.current_img = $scope.image_url[current_img_tab];
    }

    $scope.to_next_image = function() {
      if(current_img_tab < $scope.image_url.length-1) {
        current_img_tab++;
      } else {
        current_img_tab = 0;
      }
      $scope.current_img = $scope.image_url[current_img_tab];
    }

    $scope.getUserReviews = function() {
      window.location.href = "/user_reviews_h/" + $scope.id;
    }

    $scope.upvote = function() {
      var url = "/upvote_H/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            if(data.data.has_upvoted) {
              $scope.upvote_and_scrap.cnt_upvotes++;
            } else {
              $scope.upvote_and_scrap.cnt_upvotes--;
            }
            $scope.upvote_and_scrap.has_upvoted = data.data.has_upvoted;
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.scrap = function() {
      var url = "/scrap_H/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            if(data.data.has_scraped) {
              $scope.upvote_and_scrap.cnt_scraps++;
            } else {
              $scope.upvote_and_scrap.cnt_scraps--;
            }
            $scope.upvote_and_scrap.has_scraped = data.data.has_scraped;
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.submit_comment = function() {
      $http({
        method: 'post',
        url: 'new_comment_H',
        data: { review_house_id: $scope.id,
                comment: $scope.comment_writting }
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
          $scope.comment_writting = "";
        });
    }

    $scope.upvote_comment = function(comment) {
      var url = "/upvote_comment_H/"+comment.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            if(data.data.has_upvoted) {
              comment.upvote_count++;
            } else {
              comment.upvote_count--;
            }
            comment.has_upvoted = data.data.has_upvoted;
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    var opened_subcomment = [];
    $scope.showSubComments = function(comment) {
      comment.show_sub = !comment.show_sub;
      opened_subcomment.push(comment.id);
    }

    $scope.writeSubComment = function(comment) {
      comment.write_sub = true;
    }

    $scope.submit_subcomment = function(comment) {
      $http({
        method: 'post',
        url: 'new_subcomment_H',
        data: { comment_house_id: comment.id,
                comment: comment.subcomment_writting }
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.delete_comment = function(comment) {
      if(confirm("삭제하시겠습니까?")) {
        $http({
          method: 'post',
          url: 'delete_comment_H',
          data: { comment_id: comment.id }
        })
          .then(function(data, status, headers, config) {
            if(data.data.ret) {
              getComments();
            } else {
              alert("invalid operation");
            }
          });
      }
    }

    $scope.delete_subcomment = function(comment) {
      if(confirm("삭제하시겠습니까?")) {
        $http({
          method: 'post',
          url: 'delete_subcomment_H',
          data: { subcomment_id: comment.id }
        })
          .then(function(data, status, headers, config) {
            if(data.data.ret) {
              getComments();
            } else {
              alert("invalid operation");
            }
          });
      }
    }

    $scope.sort_comment = function($event, sort_by_param) {
      var $type_wrapper = angular.element($event.currentTarget).parent();
      if(sort_by_param === 'hot') {
        $type_wrapper.find('.new').removeClass('selected');
        $type_wrapper.find('.hot').addClass('selected');
        sortCommentsByHot($scope.comments);
      } else {
        $type_wrapper.find('.hot').removeClass('selected');
        $type_wrapper.find('.new').addClass('selected');
        sortCommentsByNew($scope.comments);
      }
      sort_by = sort_by_param
      initSubcommentStatus($scope.comments);
    }

    function initSubcommentStatus(comments) {
      opened_subcomment = [];
      for(var i=0; i<comments.length; i++) {
        comments[i].show_sub = false;
        comments[i].write_sub = false;
      }
    }

    function sortCommentsByHot(comments) {
      comments.sort(function (a, b) {
        return a.upvote_count > b.upvote_count ? -1 : a.upvote_count < b.upvote_count ? 1 : 0;
      });
    }

    function sortCommentsByNew(comments) {
      comments.sort(function (a, b) {
        return a.created_at > b.created_at ? -1 : a.created_at < b.created_at ? 1 : 0;
      });
    }

    function getComments() {
      var url = "/get_comments_H/"+$scope.id+".json";
      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          $scope.comments = data.data.comments
          if(sort_by === 'hot') {
            sortCommentsByHot($scope.comments);
          } else {
            sortCommentsByNew($scope.comments);
          }
          for(var i=0; i<opened_subcomment.length; i++) {
            for(var j=0; j<$scope.comments.length; j++) {
              if($scope.comments[j].id == opened_subcomment[i]) {
                $scope.comments[j].show_sub = true;
                break;
              }
            }
          }
        });
    }

    function initImagePath() {
      current_img_tab = 0;
      $scope.current_img = $scope.image_url[current_img_tab];
    }

    function setStarScore(satisfaction) {
      var $container = $('.modal-dialog .modal-content .show-modal .satisfaction-container');
      var $avr = $container.find('.avr-container').find('.stars');
      var $price = $container.find('.detail-container').find('.price').find('.stars');
      var $residence = $container.find('.detail-container').find('.residence').find('.stars');
      var $env = $container.find('.detail-container').find('.environment').find('.stars');

      setStarImgDisplay($avr, satisfaction.avr);

      setStarImgDisplay($price, satisfaction.price);
      setStarImgDisplay($residence, satisfaction.residence);
      setStarImgDisplay($env, satisfaction.env);
    }

    function setStarImgDisplay($container, score) {
      for(var i=0; i<score; i++) {
        $container.find('.score:nth-child('+(i+1)+')').find(':nth-child(1)').addClass('none');
        $container.find('.score:nth-child('+(i+1)+')').find(':nth-child(2)').removeClass('none');
      }
      for(var i=score; i<5; i++) {
        $container.find('.score:nth-child('+(i+1)+')').find(':nth-child(1)').removeClass('none');
        $container.find('.score:nth-child('+(i+1)+')').find(':nth-child(2)').addClass('none');
      }
    }

  }
]);


myApp.controller('ShowLifeCtrl', [
  '$scope',
  '$http',
  '$timeout',
  '$uibModalInstance',
  'data',

  function($scope, $http, $timeout, $uibModalInstance, data) {

    // var ROOT_PATH = "http://localhost:3000/"
    $scope.image_url = data.image_url;

    $scope.id = data.id;
    $scope.title = data.title;
    $scope.written_by = data.written_by;
    $scope.hash_tags = data.hash_tags;
    $scope.content = data.content;

    $scope.upvote_and_scrap = data.upvote_and_scrap;
    $scope.comments = [];

    $scope.comment_writting = "";
    var sort_by = 'hot'

    $timeout(function() {
      getComments();
      initImagePath();
    });

    $scope.getUserReviews = function() {
      window.location.href = "/user_reviews_l/" + $scope.id;
    }

    $scope.upvote = function() {
      var url = "/upvote_L/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            if(data.data.has_upvoted) {
              $scope.upvote_and_scrap.cnt_upvotes++;
            } else {
              $scope.upvote_and_scrap.cnt_upvotes--;
            }
            $scope.upvote_and_scrap.has_upvoted = data.data.has_upvoted;
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.scrap = function() {
      var url = "/scrap_L/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            if(data.data.has_scraped) {
              $scope.upvote_and_scrap.cnt_scraps++;
            } else {
              $scope.upvote_and_scrap.cnt_scraps--;
            }
            $scope.upvote_and_scrap.has_scraped = data.data.has_scraped;
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.submit_comment = function() {
      $http({
        method: 'post',
        url: 'new_comment_L',
        data: { review_life_id : $scope.id,
                comment: $scope.comment_writting }
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
          $scope.comment_writting = "";
        });
    }

    $scope.upvote_comment = function(comment) {
      var url = "/upvote_comment_L/"+comment.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            if(data.data.has_upvoted) {
              comment.upvote_count++;
            } else {
              comment.upvote_count--;
            }
            comment.has_upvoted = data.data.has_upvoted;
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    var opened_subcomment = [];
    $scope.showSubComments = function(comment) {
      comment.show_sub = !comment.show_sub;
      opened_subcomment.push(comment.id);
    }

    $scope.writeSubComment = function(comment) {
      comment.write_sub = true;
    }

    $scope.submit_subcomment = function(comment) {
      $http({
        method: 'post',
        url: 'new_subcomment_L',
        data: { comment_life_id: comment.id,
                comment: comment.subcomment_writting }
      })
        .then(function(data, status, headers, config) {
          if(data.data.current_user) {
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.delete_comment = function(comment) {
      if(confirm("삭제하시겠습니까?")) {
        $http({
          method: 'post',
          url: 'delete_comment_L',
          data: { comment_id: comment.id }
        })
          .then(function(data, status, headers, config) {
            if(data.data.ret) {
              getComments();
            } else {
              alert("invalid operation");
            }
          });
      }
    }
    $scope.delete_subcomment = function(comment) {
      if(confirm("삭제하시겠습니까?")) {
        $http({
          method: 'post',
          url: 'delete_subcomment_L',
          data: { subcomment_id: comment.id }
        })
          .then(function(data, status, headers, config) {
            if(data.data.ret) {
              getComments();
            } else {
              alert("invalid operation");
            }
          });
      }
    }
    $scope.sort_comment = function($event, sort_by_param) {
      var $type_wrapper = angular.element($event.currentTarget).parent();
      if(sort_by_param === 'hot') {
        $type_wrapper.find('.new').removeClass('selected');
        $type_wrapper.find('.hot').addClass('selected');
        sortCommentsByHot($scope.comments);
      } else {
        $type_wrapper.find('.hot').removeClass('selected');
        $type_wrapper.find('.new').addClass('selected');
        sortCommentsByNew($scope.comments);
      }
      sort_by = sort_by_param;
      initSubcommentStatus($scope.comments);
    }

    function initSubcommentStatus(comments) {
      opened_subcomment = [];
      for(var i=0; i<comments.length; i++) {
        comments[i].show_sub = false;
        comments[i].write_sub = false;
      }
    }

    function sortCommentsByHot(comments) {
      comments.sort(function (a, b) {
        return a.upvote_count > b.upvote_count ? -1 : a.upvote_count < b.upvote_count ? 1 : 0;
      });
    }

    function sortCommentsByNew(comments) {
      comments.sort(function (a, b) {
        return a.created_at > b.created_at ? -1 : a.created_at < b.created_at ? 1 : 0;
      });
    }

    function initImagePath() {
      if($scope.image_url) {
        $scope.image_url = $scope.image_url;
      }
    }

    function getComments() {
      var url = "/get_comments_L/"+$scope.id+".json";
      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          $scope.comments = data.data.comments
          if(sort_by === 'hot') {
            sortCommentsByHot($scope.comments);
          } else {
            sortCommentsByNew($scope.comments);
          }
          for(var i=0; i<opened_subcomment.length; i++) {
            console.log(opened_subcomment[i])
            for(var j=0; j<$scope.comments.length; j++) {
              if($scope.comments[j].id == opened_subcomment[i]) {
                $scope.comments[j].show_sub = true;
                break;
              }
            }
          }
        });
    }

  }
]);
