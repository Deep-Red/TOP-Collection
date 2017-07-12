angular.module('flapperNews')
.factory('posts', [
  '$http',
  function($http){
  var o = {
    posts: []
  };
  o.getAll = function() {
    return $http.get('/posts.json').then(function(data){
      console.log(o);
      angular.copy(data, o.posts);
      console.log(o);
    });
  };
  o.create = function(post) {
    return $http.post('/posts.json', post).then(function(data){
      console.log(data);
      o.posts.push(data);
      console.log(o);
    });
  };
  o.upvote = function (post) {
    return $http.put('/posts/' + '/upvote.json')
    .then(function(data){
      post.upvotes += 1;
    });
  };
  return o;
}])
