$(document).ready(function() {

var slideout = function() {

}

var next = function() {

  var oldslide =  $('.previous');
  var currslide = $('.active');
  oldslide.removeClass('previous');
  currslide.addClass('previous');
  currslide.removeClass('active');
  if (currslide.hasClass('last')) {
    var newslide = currslide.siblings().filter(':first');
    $('.slide').animate({"left": "show"}, 600);
  } else {
    var newslide = currslide.next();
    currslide.animate({"left": "toggle" }, 600);
  };
  newslide.addClass('active');

};

$('#next-btn').click(function() {
  console.log("AA");
  next();
});

});
