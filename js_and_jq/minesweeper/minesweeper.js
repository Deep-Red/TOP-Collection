$(document).ready(function() {

var Cell = function(mined, flagged, x, y) {
  this.coord = [x, y];
  this.mined = mined || false;
  this.flagged = flagged || false;
  this.touching = 0;
}

var Board = function(rows, cols, mines){
  this.rows = rows || 9;
  this.cols = cols || this.rows;
  cells = []
  for (var i = 0; i < rows; i++) {
    $('#minefield').append("<div class='row' id='row-"+i+"'></div>");
    cells.push([]);
    console.log("i" + cells);
  }
  for (var j = 0; j < rows; j++) {
    for(var k = 0; k < cols; k++) {
      $('#row-'+j).append("<div class='cell' id='cell-"+j+k+"'></div>");
      cells[j].push(new Cell(false, false, j, k));
    }
  }
  console.log(cells);
}

var setMines = function(count) {
  for (i = 0; i < count; i++) {
    r = Math.floor(Math.random() * height);
    c = Math.floor(Math.random() * width);
    cells[r][c].mined = true;
    console.log(r+" "+c);
  }
}
//Board.prototype.render = function(){
//  setMines: function() {
//
//  },

//};


var height = 9;
var width = 9;
var mines = 9;
var board = new Board(height, width, mines);
setMines(mines);

$('.cell').on('click', function() {
  console.log(event.target.id + event.which);
});
$('.cell').on('contextmenu', function(){
  event.preventDefault();
  console.log(event.target.id + event.which);
  $(this).toggleClass('flagged');
  r = event.target.id.split("")[5];
  c = event.target.id.split("")[6];
  cells[r][c].flagged = !cells[r][c].flagged;
})

});
