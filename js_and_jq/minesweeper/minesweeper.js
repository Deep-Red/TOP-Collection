$(document).ready(function() {

var Cell = function(mined, flagged) {
  this.mined = mined || false;
  this.flagged = flagged || false;
}

var Board = function(rows, cols, mines){
  this.rows = rows || 9;
  this.cols = cols || this.rows;
  for (var i = 0; i < rows; i++) {
    $('#minefield').append("<div class='row'></div>");
  }
  for (var j = 0; j < cols; j++) {
    $('.row').append("<div class='cell'></div>");
  }
}

//Board.prototype.render = function(){
//  setMines: function() {
//
//  },

//};



var board = new Board(9, 9, 9);
});
