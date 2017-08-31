var map;
var marker;
var message;
var usrlat;
var usrlng;
var infowindow;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: marker ? marker.position : {lat: 40.7413549, lng: -73.9980244},
      zoom: 7,
      mapTypeControl: false
    });
};

$('#map-it').on('click', function() {
  message = $('#message').val();
  usrlat = parseFloat($('#latitude').val());
  usrlng = parseFloat($('#longitude').val());
  marker = new google.maps.Marker({
    position: {lat: usrlat, lng: usrlng},
    animation: google.maps.Animation.DROP
  });
  infowindow = new google.maps.InfoWindow({
    content: message
  });
  console.log(marker.position);
  console.log(message);
  initMap();
  marker.setMap(map);
  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
});
