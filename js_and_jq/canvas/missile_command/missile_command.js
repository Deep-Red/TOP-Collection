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
var centerMissiles = [];
var eastMissiles = [];
var westMissiles = [];
var incomingMissiles = [];

var centerSilo = {
  x: 300,
  y: 330
};

var eastSilo = {
  x: 545,
  y: 340
};

var westSilo = {
  x: 55,
  y: 340
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

// make missiles
function Missile(x, y, vx, vy) {
  this.xp = x || 0,
  this.yp = y || 0,
  this.xv = vx || 0,
  this.yv = vy || 0
}
//draw missiles
var drawMissile = function(missile) {
  c.fillStyle = "#DDDDDD";
//  console.log(missile);
  c.fillRect(missile.xp, missile.yp, 4, 4);
}
// populate central missiles
for (var i = 335; i <= 383; i += 12) {
  for (var j = 283; j <= 313; j += 10) {
    var newMissile = new Missile(j, i);
    centerMissiles.push(newMissile);
  }
}

// west
for (var i = 345; i <= 381; i += 12) {
  for (var j = 48; j <= 58; j += 10) {
    var newMissile = new Missile(j, i);
    westMissiles.push(newMissile);
  }
}

// east
for (var i = 345; i <= 381; i+= 12) {
  for (var j = 538; j <= 548; j += 10) {
    var newMissile = new Missile(j, i);
    eastMissiles.push(newMissile);
  }
}

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
    rise: Math.abs(pos.y - silo.y),
    run: Math.abs(pos.x - silo.x),
    velocity: 1,
  }
  return trajectory;
}

function fireMissile(event, silo) {
  var traj = targeting(event, silo);
  firedMissiles.push({
    x: centerSilo.x,
    y: centerSilo.y,
    vector: (traj.rise / traj.run)
  })
//  console.log(firedMissiles[firedMissiles.length-1]);
//  console.log("Feuer!"+reticule.x+","+reticule.y+" from "+silo.x + "," +silo.y);
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
//  console.log(centerMissiles.length);
//  console.log("Update");
};

function draw() {
  for (var i = 0; i < centerMissiles.length; i++) {
    drawMissile(centerMissiles[i]);
  };
  for (var i = 0; i < westMissiles.length; i++) {
    drawMissile(westMissiles[i]);
  };
  for (var i = 0; i < eastMissiles.length; i++) {
    drawMissile(eastMissiles[i]);
  }
  for (var i = 0; i < firedMissiles.length; i++) {
    drawMissile(firedMissiles[i]);
  }
  for (var i = 0; i < incomingMissiles.length; i++) {
    drawMissile(incomingMissiles[i]);
  }
};
