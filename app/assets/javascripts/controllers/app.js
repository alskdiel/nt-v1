var myApp = angular.module('myApp', ['ui.bootstrap']);

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
  '$uibModal',

  function($scope, $http, $uibModal) {
    $scope.test = "helloworld!!!";
    var $grid = $('.grid');

    $grid.masonry({
      itemSelector: '.grid-item',
      columnWidth: 275
    });
    $scope.getCardDetail = function(id) {
      console.log(id);
      var url = "/review_houses/"+id+".json";

      $http({
        method: 'get',
        url: url,
      })
        .then(function(data, status, headers, config) {
          // console.log(data);

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
    });

    $scope.upvote = function() {
      var url = "/upvote/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
          if(data.data.current_user) {
            if(data.data.has_upvoted) {
              $scope.upvote_and_scrap.cnt_upvotes++;
              $scope.upvote_and_scrap.has_upvoted = true;
            } else {
              $scope.upvote_and_scrap.cnt_upvotes--;
              $scope.upvote_and_scrap.has_upvoted = false;
            }
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.scrap = function() {
      var url = "/scrap/"+$scope.id;
      $http({
        method: 'post',
        url: url,
      })
        .then(function(data, status, headers, config) {
          console.log(data);
          if(data.data.current_user) {
            if(data.data.has_scraped) {
              $scope.upvote_and_scrap.cnt_scraps++;
              $scope.upvote_and_scrap.has_scraped = true;
            } else {
              $scope.upvote_and_scrap.cnt_scraps--;
              $scope.upvote_and_scrap.has_scraped = false;
            }
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    $scope.submit_comment = function() {
      $http({
        method: 'post',
        url: 'new_comment',
        data: { review_house_id: $scope.id,
                comment: $scope.comment_writting }
      })
        .then(function(data, status, headers, config) {
          console.log(data);
          if(data.data.current_user) {
            // get comments
            getComments();
          } else {
            alert("로그인 해 주세요");
          }
        });
    }

    function getComments() {
      var url = "/get_comments/"+$scope.id+".json";
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
