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
      if (!this.grid[y]) {
        console.warn("No such Y coordinate: %i (grid size is: x[%i], y[%i])", y, this.colsCount, this.rowsCount);
        return false;
      }
      if (!this.grid[x]) {
        console.warn("No such X coordinate: %i (grid size is: x[%i], y[%i])", x, this.colsCount, this.rowsCount);
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
    this.body = [[this.head]];
    this.direction = config.direction;
  };

  Snake.prototype = {
    render: function ( options ) {
//      Grid.getCellAt(options.body).$el.css('background', 'blue');
    }
  }

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
  console.log(snake.head[0]);
  grid.getCellAt(snake.head[0], snake.head[1]).$el.css('background', 'blue');
}());
