$(document).ready(function() {

var board = function() {
  $("#boardbox").append("<div class='grid'></div>");
  for (var i = 0; i < 3; ++i){
    $(".grid").append("<div class='row' id='row-"+i+"'></div>");
  }
  for (var j = 0; j < 3; ++j){
    $(".row").append("<div class='square square-"+j+" empty-square'></div>");
  }
}


var turns = 0;
board();

function makeMove() {
  if ($(this).hasClass('empty-square'))
  {
    turns++;
    if (turns % 2) {
      $(this).removeClass("empty-square") && $(this).append("<p>X</p>");
    } else {
      $(this).removeClass("empty-square") && $(this).append("<p>O</p>");
    }
  }
};


$(".square").on('click', function() {
  makeMove.call(event.target);
});

});
