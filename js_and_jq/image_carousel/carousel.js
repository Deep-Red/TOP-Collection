$(document).ready(function() {

var slideout = function() {

}

var next = function() {

  var $allslides = $('.slides');
  var $oldslide =  $('.previous');
  var $currslide = $('.active');
  var cswidth = $currslide.width();

  $oldslide.removeClass('previous');
  $currslide.addClass('previous');
  $currslide.removeClass('active');

  if ($currslide.next().hasClass('last')) {
    $allslides.animate({"margin-left": "-=" + cswidth}, 1200, function() {
      $(this).css('margin-left', 0)});
    var newslide = $currslide.siblings().filter(':first');
  } else {
    $allslides.animate({"margin-left": "-=" + cswidth}, 1200);
    var newslide = $currslide.next();
  };

  newslide.addClass('active');

};

var prev = function() {

  var $allslides = $('.slides');
  var $oldslide =  $('.previous');
  var $currslide = $('.active');
  var cswidth = $currslide.width();
  var slidescount = $('.slide').length;

  $oldslide.removeClass('previous');
  $currslide.addClass('previous');
  $currslide.removeClass('active');

  if ($currslide.prev().hasClass('first') || $currslide.hasClass('first')) {
    $allslides.animate({"margin-left": "+=" + cswidth}, 1200, function() {
      $(this).css('margin-left', (-cswidth * (slidescount-1)))});
    var newslide = $currslide.siblings().filter(':last');
  } else {
    $allslides.animate({"margin-left": "+=" + cswidth}, 1200);
    var newslide = $currslide.prev();
  };

  newslide.addClass('active');

}

$('.next-btn').click(function() {
  console.log("Next Slide");
  next();
});

$('.prev-btn').click(function() {
  console.log("Previous Slide");
  prev();
})

});
