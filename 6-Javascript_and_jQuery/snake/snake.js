//var grid = new Grid({rows: 40, cols: 40});
//grid.render({placeholder: "#field"});

//var cell = grid.getCellAt(20,20);

(function( global ) {
  "use strict";

  function Cell( config ) {
    this.$el = config.$element;
    this.x = config.x;
    this.y = config.y;
  }

  function Grid( config ) {
    this.grid = [];
    this.cells = [];
    this.rowsCount = config.rows;
    this.colsCount = config.cols;
    this.rows = [];
    this.cols = [];
    if (config.render) {
      this.placeholder = config.render.placeholder;
      this.render();
    }
  }

  Grid.prototype = {
    createCell: function( config ) {
      return new Cell(config);
    },
    getCellAt: function( x,y ) {
      if (!this.grid[x]) {
        console.warn("No such X coordinate: %i (grid size is: x[%i], y[%i])", x, this.colsCount, this.rowsCount);
        return false;
      }
      if (!this.grid[y]) {
        console.warn("No such Y coordinate: %i (grid size is: x[%i], y[%i])", y, this.colsCount, this.rowsCount);
        return false;
      }
      return this.grid[y][x];
    },
    render: function( options ) {
      if (options && options.placeholder) {
        this.placeholder = options.placeholder;
      }
      this.$placeholder = $(this.placeholder);
      if (!this.placeholder || this.$placeholder.length === 0) {
        console.error('Placeholder is not present');
        return;
      }
      var i, j, $row, $cell, cell, cellID = 0;
      for (i = 0; i < this.rowsCount; i += 1) {
        this.grid[i] = [];
        $row = $('<div class="row"></div>').prependTo(this.$placeholder);
        for (j = 0; j < this.colsCount; j += 1) {
          $cell = $('<div class="cell"></div>').appendTo($row);
          cell = this.createCell({$element: $cell, x: j, y: i});
          this.grid[i].push(cell);
          this.cells.push(cell);
        }
      }
      // rows
      var self = this;
      this.grid.forEach(function( row ){
        self.rows.push(row);
      });
    }
  };

  function Snake( config ) {
    this.head = [config.x, config.y];
    this.body = [this.head];
    this.direction = config.direction;
  };

  Snake.prototype = {
    render: function ( options ) {
//      Grid.getCellAt(options.body).$el.css('background', 'blue');
    }
  }

  global.Playing = false;
  global.Grid = Grid;
  global.Snake = Snake;
}( window ));

(function() {
  "use strict";

  var grid = new Grid({
    rows: 40,
    cols: 40,
    render: {
      placeholder: ".grid"
    }
  });
  var snake = new Snake({
    x: 20,
    y: 20,
    direction: "E"
  });
  console.log(snake);

var rendersnake = function(){
  grid.getCellAt(snake.head[0], snake.head[1]).$el.addClass("snakehead");
  if (snake.body.length > 1) {

    grid.getCellAt(snake.body[0][0], snake.body[0][1]).$el.removeClass("snakehead");
    grid.getCellAt(snake.body[0][0], snake.body[0][1]).$el.addClass("snakebody");
    grid.getCellAt(snake.body[snake.body.length-1][0], snake.body[snake.body.length-1][1]).$el.attr('class', 'cell');

  };
};

var score = 0;
var foodvalue = 10;
var timer = 1100;

var renderfood = function() {

  jQuery(".food").removeClass("food");
  $('.foodvalue').remove();
  var a = (Math.floor(Math.random()*40));
  var b = (Math.floor(Math.random()*40));

/* implement logic to keep food from appearing in same square as snake
  if inArray([a, b], snake.body) === -1 {
    renderfood();
  };
*/
  foodvalue += (10 * snake.body.length);
  var foodsquare = [a, b];
  window.foodsquare = foodsquare;
  grid.getCellAt(a, b).$el.addClass("food");
  jQuery(".food").append('<p class="foodvalue">'+foodvalue+'</p>');
}

var eatfood = function() {
  score += foodvalue;
  $('#score').replaceWith("<div id=score>"+score+"</div>");
  snake.body.push(snake.body[snake.body.length-1]);
  timer *= .75;
}

var gameover = function(){
  Playing = false;
  console.log("Game Over");
}

var selfcollide = function(){
  if (this === undefined)
    return false;

  (this[0] === snake.head[0]) && (this[1] === snake.head[1]);
}

$('.stats').append("<div id=score>"+score+"</div>");

rendersnake();
renderfood();
var turn = function() {
  if (Playing) {

    if ((snake.head[0] > 40) || (snake.head[1] > 40) || (snake.head[0] < 0) || (snake.head[1] < 0)) {
      gameover();
    };

    if (jQuery(".snakehead").hasClass("snakebody")) {
      gameover();
    };

    if ((window.foodsquare[0] === snake.head[0]) && (window.foodsquare[1] === snake.head[1])) {
      eatfood();
      renderfood();
    };

    switch (snake.direction) {
      case "E":
      var newsegment = jQuery.extend({}, snake.head);
      snake.head[0]++;
      snake.body.unshift(newsegment);
      rendersnake();
      console.log(snake.head);
      break;
      case "W":
      var newsegment = jQuery.extend({}, snake.head);
      snake.head[0]--;
      snake.body.unshift(newsegment);
      rendersnake();
      break;
      case "S":
      var newsegment = jQuery.extend({}, snake.head);
      snake.head[1]--;
      snake.body.unshift(newsegment);
      rendersnake();
      break;
      case "N":
      var newsegment = jQuery.extend({}, snake.head);
      snake.head[1]++;
      snake.body.unshift(newsegment);
      rendersnake();
      break;
      default:
      console.log("default move switch " + snake);
    };
    snake.body.pop();
  };
  setTimeout(turn, timer);
};

turn();
/*
var turn = window.setTimeout(function() {
  if (Playing) {
    console.log("HHHHHH");
  };
}, 500);
*/

$(window).keypress(function( event ) {
  console.log(event.which);
  switch (event.which) {
    case 97 || 65:
      snake.direction = "W";
      break;
    case 115 || 83:
      snake.direction = "S";
      break;
    case 119 || 87:
      snake.direction = "N";
      break;
    case 100 || 68:
      snake.direction = "E";
      break;
    case 32:
      Playing = !Playing;
      console.log(Playing);
//      Playing && gameplay();
      break;
    default:
      console.log("Unrecognized Command");
  }
})

})();
