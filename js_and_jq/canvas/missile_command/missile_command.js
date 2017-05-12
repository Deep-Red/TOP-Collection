// set environment
var canvas = document.getElementById('canvas');
var c = canvas.getContext('2d');


//set variables
var FPS = 1;
setInterval(function() {
  update();
  draw();
}, 1000/30);

var reticule = {
  x: c.width/2 - 15,
  y: c.height/2 - 15,
  radius: 10,
  fired: false
};

// draw background
c.fillStyle = "#002040";
c.fillRect(0,0,600,400);

// draw ground
c.fillStyle = "#B0A892";
c.fillRect(0,350,600,50);

// draw base
c.beginPath();
c.moveTo(270,350);
c.lineTo(280,330);
c.lineTo(320,330);
c.lineTo(330,350);
c.closePath();
c.fill();

c.beginPath();
c.moveTo(40, 350);
c.lineTo(45, 340);
c.lineTo(65, 340);
c.lineTo(70, 350);
c.fill();

c.beginPath();
c.moveTo(530, 350);
c.lineTo(535, 340);
c.lineTo(555, 340);
c.lineTo(560, 350);
c.fill();

//draw missiles
//mid
c.fillStyle = "#DDDDDD";
var missilesc = [
c.fillRect(283,335,4,9),
c.fillRect(293,335,4,9),
c.fillRect(303,335,4,9),
c.fillRect(313,335,4,9),
c.fillRect(283,347,4,9),
c.fillRect(293,347,4,9),
c.fillRect(303,347,4,9),
c.fillRect(313,347,4,9),
c.fillRect(283,359,4,9),
c.fillRect(293,359,4,9),
c.fillRect(303,359,4,9),
c.fillRect(313,359,4,9),
c.fillRect(283,371,4,9),
c.fillRect(293,371,4,9),
c.fillRect(303,371,4,9),
c.fillRect(313,371,4,9),
c.fillRect(283,383,4,9),
c.fillRect(293,383,4,9),
c.fillRect(303,383,4,9),
c.fillRect(313,383,4,9),
];
//west
missilesw = [
c.fillRect(48,345,4,9),
c.fillRect(58,345,4,9),
c.fillRect(48,357,4,9),
c.fillRect(58,357,4,9),
c.fillRect(48,369,4,9),
c.fillRect(58,369,4,9),
c.fillRect(48,381,4,9),
c.fillRect(58,381,4,9),
];
//east
missilese = [
c.fillRect(538,345,4,9),
c.fillRect(548,345,4,9),
c.fillRect(538,357,4,9),
c.fillRect(548,357,4,9),
c.fillRect(538,369,4,9),
c.fillRect(548,369,4,9),
c.fillRect(538,381,4,9),
c.fillRect(548,381,4,9),
];

// draw cities
c.fillStyle = "#778899";
c.fillRect(100,340,20,10);
c.fillRect(105,335,10,10);

c.fillRect(150,340,20,10);
c.fillRect(155,335,10,10);

c.fillRect(200,340,20,10);
c.fillRect(205,335,10,10);

c.fillRect(385,340,20,10);
c.fillRect(390,335,10,10);

c.fillRect(435,340,20,10);
c.fillRect(440,335,10,10);

c.fillRect(485,340,20,10);
c.fillRect(490,335,10,10);

$(function() {
  window.keydown = {};

  function keyName(event) {
    return jQuery.hotkeys.specialKeys[event.which] ||
      String.fromCharCode(event.which).toLowerCase();
  }
  $(document).bind("keydown", function(event) {
    keydown[keyName(event)] = true;
  });
  $(document).bind("keyup", function(event) {
    keydown[keyName(event)] = false;
  });
});

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
      x: evt.clientX - rect.left,
      y: evt.clientY - rect.top
    };
}

function targeting(e, silo) {
  var pos = getMousePos(canvas, e);
  reticule.x = pos.x;
  reticule.y = pos.y;
  var trajectory = {
    rise = Math.abs(pos.y - silo.y),
    run = Math.abs(pox.x - silo.x),
    velocity = 1,
  }
}

function fireMissile(event, silo) {
  targeting(event, silo);
  console.log("Feuer!"+reticule.x+","+reticule.y+" from "+silo);
};


$('#canvas').on('click', function(e) {
  event.preventDefault();
  var mousePos = getMousePos(canvas, event);
  event.stopPropagation();
  var silo = "center";
  if (keydown.w) {
    silo = "west";
  }
  if (keydown.e) {
    silo = "east";
  }
  fireMissile(event, silo);
});

function update() {

//  console.log("Update");
};

function draw() {
//  console.log("Draw");
};
