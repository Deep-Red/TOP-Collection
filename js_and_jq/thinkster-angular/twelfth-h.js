function testService($http) {
  this.get = function () {
    return $http.get('http://test-routes.herokuapp.com/test.hello')
      .then(function(res){
        return res.data.message;
      })
  }
  this.upperCase = function(data) {
    return $http.post('http://test-routes.herokuapp.com/test/uppercase', data)
  }
}

function TestCtrl(testService) {
  var self = this;

  self.getMessage = function() {
    testService.get()
      .then(function(message) {
        self.message = message;
      })
  }

  self.postData = function(message) {
    testService.upperCase({message: message})
      .success(function(body) {
        self.sendMessage = body.message;
      })
  }
}


angular.module('app', [])
.service('testService', testService)
.controller('TestCtrl', TestCtrl)
