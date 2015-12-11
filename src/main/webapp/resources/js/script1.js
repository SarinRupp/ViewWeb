

var app = angular.module('myApp', []);
app.controller('planetController', function($scope,$http) {
  $http.post("listStudent").success(function(data) {
	  $scope.names = data;	  	
	  
  		});  
  /*$http.post("listclass").success(function(data) {
	  $scope.stuclass = data;	  	
	  alert(data);
  		}); */
	
});




