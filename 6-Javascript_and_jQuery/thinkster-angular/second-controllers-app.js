angular.module('second-controllers-app', []);

angular.module('second-controllers-app').controller('MainCtrl', function($scope){
  var self = this;
  self.message = 'hello';

  self.changeMessage = function(message){
    self.message = message;
  };
});
