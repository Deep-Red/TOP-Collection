function TestCtrl($templateCache) {
  this.user = {name: 'Blake'};
  console.log($templateCache.get('eleventh-test.html'));
}

angular.module('app', ['ngRoute'])
.config(function($routeProvider){
  $routeProvider.when('/', {
    controller: 'TestCtrl as test',
    templateUrl: 'eleventh-test.html'
  })
  .otherwise('/');
})
.controller('TestCtrl', TestCtrl);

angular.module('app').run(function ($templateCache){
  $templateCache.put('eleventh-test.html', 'Hello {{ test.user.name }}')
});
