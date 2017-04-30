$(document).ready(function() {

var slideout = function() {

}

var next = function() {

  var allslides = $('.slides');
  var oldslide =  $('.previous');
  var currslide = $('.active');
  var cswidth = currslide.width();

  oldslide.removeClass('previous');
  currslide.addClass('previous');
  currslide.removeClass('active');
  if (currslide.next().hasClass('last')) {
    allslides.animate({"margin-left": "-=" + cswidth}, function() {
      $(this).css('margin-left', 0)});
    var newslide = currslide.siblings().filter(':first');
  } else {
    allslides.animate({"margin-left": "-=" + cswidth});
    var newslide = currslide.next();
  };
  newslide.addClass('active');

};

$('#next-btn').click(function() {
  console.log("AA");
  next();
});

});
