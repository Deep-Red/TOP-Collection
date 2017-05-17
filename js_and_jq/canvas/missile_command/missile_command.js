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

var firedMissiles = [];
var incomingMissiles = [];

var cities = [];

var centerSilo = {
  missiles: [],
  x: 300,
  y: 330
};

var eastSilo = {
  missiles: [],
  x: 545,
  y: 340
};

var westSilo = {
  missiles: [],
  x: 55,
  y: 340
};

function drawScene() {
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
};


// make missiles
function Missile(x, y, vx, vy) {
  this.xp = x || 0,
  this.yp = y || 0,
  this.xv = vx || 0,
  this.yv = vy || 0
}
// make cities
function City(pos, dmg) {
  this.a = pos,
  this.b = (pos + 5),
  this.dmg = dmg || 0
}

//draw missiles
var drawMissile = function(missile) {
  c.fillStyle = "#DDDDDD";
//  console.log(missile);
  c.fillRect(missile.xp, missile.yp, 4, 4);
}
var drawCity = function(city) {
  c.fillStyle = "#778899";
  c.fillRect(city.a, 340, 20, 10);
  c.fillRect(city.b, 335, 10, 10);
}

// populate central missiles
for (var i = 335; i <= 383; i += 12) {
  for (var j = 283; j <= 313; j += 10) {
    var newMissile = new Missile(j, i);
    centerSilo.missiles.push(newMissile);
  }
}
// west
for (var i = 345; i <= 381; i += 12) {
  for (var j = 48; j <= 58; j += 10) {
    var newMissile = new Missile(j, i);
    westSilo.missiles.push(newMissile);
  }
}
// east
for (var i = 345; i <= 381; i+= 12) {
  for (var j = 538; j <= 548; j += 10) {
    var newMissile = new Missile(j, i);
    eastSilo.missiles.push(newMissile);
  }
}

// make cities
for (var i = 100; i <= 200; i += 50) {
  var newCity = new City(i);
  cities.push(newCity);
}
for (var i = 385; i <= 485; i += 50) {
  var newCity = new City(i);
  cities.push(newCity);
  console.log(cities);
}

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
  console.log(pos.x +" " + " " +pos.y);
  console.log(silo.x+" "+" "+silo.y);
  var rise = Math.abs(pos.y - silo.y);
  var run = -1 * (pos.x - silo.x);
  var velocity = 11;
  var ao = Math.abs(rise) + Math.abs(run);
  console.log(rise + " " + run + " " + ao);
  var trajectory = {
    vy: 1 + Math.floor(velocity / ao * run),
    vx: 1 + Math.abs(Math.floor(velocity / ao * rise))
  }
  return trajectory;
}

function fireMissile(event, silo) {
  var traj = targeting(event, silo);
  var source = silo.name+"Missiles";
  var activeMissile = silo.missiles.shift();

//  console.log(activeMissile);
  activeMissile.xv = traj.vy;
  activeMissile.yv = traj.vx;
  firedMissiles.push(activeMissile);
  console.log(traj);
//  console.log(centerSilo.missiles.length);
//  console.log(firedMissiles.length);
};


$('#canvas').on('click', function(e) {
  event.preventDefault();
  var mousePos = getMousePos(canvas, event);
  event.stopPropagation();
  var silo = centerSilo;
  if (keydown.w) {
    silo = westSilo;
  }
  if (keydown.e) {
    silo = eastSilo;
  }
  fireMissile(event, silo);
});

function update() {
  for(var i = 0; i < firedMissiles.length; i++) {
    var m = firedMissiles[i];
    m.xp -= m.xv;
    m.yp -= m.yv;
  }
};
function draw() {
  c.clearRect(0,0,600,400);
  drawScene();
  drawMissiles();
  drawCities();
};

function drawCities() {
  for (var i = 0; i < cities.length; i++) {
    drawCity(cities[i]);
  };
};

function drawMissiles() {
  for (var i = 0; i < centerSilo.missiles.length; i++) {
    drawMissile(centerSilo.missiles[i]);
  };
  for (var i = 0; i < westSilo.missiles.length; i++) {
    drawMissile(westSilo.missiles[i]);
  };
  for (var i = 0; i < eastSilo.missiles.length; i++) {
    drawMissile(eastSilo.missiles[i]);
  }
  for (var i = 0; i < firedMissiles.length; i++) {
    drawMissile(firedMissiles[i]);
  }
  for (var i = 0; i < incomingMissiles.length; i++) {
    drawMissile(incomingMissiles[i]);
  }
};
