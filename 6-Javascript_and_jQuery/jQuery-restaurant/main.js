$(document).ready(function() {
  loadhome();
  $('li').click(function() {
    $('.active').removeClass('active');
    $(this).addClass('active');
  });
  $('#home-tab').click(function() {
    loadhome();
  });
  $('#menu-tab').click(function() {
    loadmenu();
  });
  $('#contact-tab').click(function() {
    loadcontact();
  });
});

var loadhome = function() {
  $('#content').empty();
  $('#content').append('<h1>The Restaurant at the end of Texas</h1>');
  $('#content').append('<img alt="Flag of Texas" src="http://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Flag_of_Texas.svg/125px-Flag_of_Texas.svg.png">');
  $('#content').append('<p>At the restaurant you can meet and dine with (mayan meetan con with dinan on when) a fascinating cross-section of the entire population of space and time.</p>');
};

var loadmenu = function() {
  $('#content').empty();
  $('#content').append('<h1>Menu from the End of Texas</h1>');
  $('#content').append('<p>We serve one thing here:</p><p>Alien Rattlesnake</p>');
}

var loadcontact = function() {
  $('#content').empty();
  $('#content').append('<h1>Contact Us</h1>');
  $('#content').append('<h2>Hate the food? Need to make a reservation? Just want directions?<h2>');
  $('#content').append('<p>You are no longer stuck with NASA</p><p>You could also contact SpaceX or try to hitch a ride on the border wall hyperloop!</p>');
}
