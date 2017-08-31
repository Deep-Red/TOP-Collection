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
  $('.active-dot').removeClass("active-dot");

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
  $('.active-dot').removeClass("active-dot");

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

$(".dot").click(function() {
  var cswidth = $(".active").width();
  console.log(cswidth);
  $(".slide").removeClass("active");
  $(".dot").removeClass("active-dot");
  $(event.target).addClass("active-dot");
  switch (event.target.id) {
    case "dot-2":
    $(".slides").css('margin-left', (-cswidth));
    $('#slide-2').addClass("active");
    break;
    case "dot-3":
    $(".slides").css('margin-left', (-cswidth * 2));
    $('#slide-3').addClass("active");
    break;
    case "dot-4":
    $(".slides").css('margin-left', (-cswidth * 3));
    $('#slide-4').addClass("active");
    break;
    case "dot-5":
    $(".slides").css('margin-left', (-cswidth * 4));
    $('#slide-5').addClass("active");
    break;
    case "dot-6":
    $(".slides").css('margin-left', 0);
    $('#slide-1').addClass("active");
    break;
    default:
    console.log( "df" );
    break;
  }

});

$('.next-btn').click(function() {
  console.log("Next Slide");
  next();
});

$('.prev-btn').click(function() {
  console.log("Previous Slide");
  prev();
})

setInterval(function () {
next();
}, 3000);

});
