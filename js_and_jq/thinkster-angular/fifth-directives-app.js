angular.module('greetings', [])
.directive("welcome", function() {
  return {
    restrict: "E",
    scope: {},
    template: "<div>This is the welcome component</div>",
    controller: function($scope){
      $scope.words = [];
      this.sayHello = function() {
        $scope.words.push("hello");
      };
      this.sayHowdy = function(){
        $scope.words.push("howdy");
      };
      this.sayHi = function(){
        $scope.words.push("hi");
      };
    },
    link: function(scope, element){
      element.bind("mouseenter", function() {
        console.log(scope.words);
      });
    }
  }
})

.directive("hello", function(){
  return{
    require: "welcome",
    link: function(scope, element, attrs, welcomeCtrl){
      welcomeCtrl.sayHowdy();
    }
  };
})

.directive("howdy", function(){
  return {
    require: "welcome",
    link: function (scope, element, attrs, welcomeCtrl) {
      welcomeCtrl.sayHowdy();
    }
  };
})

.directive("hi", function(){
  return {
    require: "welcome",
    link: function(scope, element, attrs, welcomeCtrl) {
      welcomeCtrl.sayHi();
    }
  };
})

.directive("goodbye", function() {
  return {
    restrict: "A",
    link: function(){
      alert("See ya later!");
    }
  }
});

angular.module('functionalities', [])
.directive("entering", function(){
 return function(scope, element, attrs) {
      element.bind("mouseenter", function(){
        console.log("Mouse has entered the div");
        element.addClass(attrs.entering);
      })
    }
})

.directive("leaving", function(){
  return function(scope, element, attrs) {
    element.bind("mouseleave", function(){
      console.log("Mouse has exited the div");
      element.removeClass(attrs.entering);
    })
  }
});

function FunCtrl() {
  var self= this;
  self.start = function() {
    console.log("Fun times have been started");
  }
  self.end = function() {
    console.log("Fun time is over.");
  }
}

angular.module('coolApp', [])
.controller('FunCtrl', FunCtrl)
.directive("entering", function(){
  return function(scope, element, attrs) {
    element.bind("mouseenter", function(){
      scope.$apply(attrs.entering);
    })
  }
})
