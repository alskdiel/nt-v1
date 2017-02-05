var myApp = angular.module('myApp', ['ui.bootstrap', 'wu.masonry']);

myApp.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

myApp.controller('MainCtrl', [
  '$scope',
  function($scope) {
  }
]);


myApp.controller('IndexCtrl', [
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
    var input_type = window.location.pathname;
      if(input_type === "/") {
        getAllReviews();
      } else if(input_type === "/review_houses") {
        getOneroomReviews();
      } else if(input_type === "/review_lives") {
        getLifeReviews();
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
  }

]);


myApp.controller('ShowCtrl', [
  '$scope',
  '$http',
  '$timeout',
  '$uibModalInstance',
  'data',

  function($scope, $http, $timeout, $uibModalInstance, data) {
    console.log(data);

    var ROOT_PATH = "http://localhost:3000/"
    var current_img_tab;
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
      $scope.current_img = ROOT_PATH+$scope.image_url[current_img_tab];
    }

    $scope.to_next_image = function() {
      if(current_img_tab < $scope.image_url.length-1) {
        current_img_tab++;
      } else {
        current_img_tab = 0;
      }
      $scope.current_img = ROOT_PATH+$scope.image_url[current_img_tab];
    }

    $scope.upvote = function() {
      var url = "/upvote_H/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
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
          console.log(data);
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
          console.log(data);
          if(data.data.current_user) {
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.upvote_comment = function(comment) {
      var url = "/upvote_comment_H/"+comment.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
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

    function getComments() {
      var url = "/get_comments_H/"+$scope.id+".json";
      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
          $scope.comments = data.data.comments
          console.log($scope.comments);
        });
    }

    function initImagePath() {
      current_img_tab = 0;
      $scope.current_img = ROOT_PATH + $scope.image_url[current_img_tab];
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
    console.log(data);

    var ROOT_PATH = "http://localhost:3000/"
    $scope.image_url = data.image_url;

    $scope.id = data.id;
    $scope.title = data.title;
    $scope.written_by = data.written_by;
    $scope.hash_tags = data.hash_tags;
    $scope.content = data.content;

    $scope.upvote_and_scrap = data.upvote_and_scrap;
    $scope.comments = [];

    $scope.comment_writting = "";

    $timeout(function() {
      getComments();
      initImagePath();
    });

    $scope.upvote = function() {
      var url = "/upvote_L/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
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
          console.log(data);
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
          console.log(data);
          if(data.data.current_user) {
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.upvote_comment = function(comment) {
      var url = "/upvote_comment_L/"+comment.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
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

    function initImagePath() {
      if($scope.image_url) {
        $scope.image_url = ROOT_PATH + $scope.image_url;
      }
    }

    function getComments() {
      var url = "/get_comments_L/"+$scope.id+".json";
      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
          $scope.comments = data.data.comments
          console.log($scope.comments);
        });
    }

  }
]);
