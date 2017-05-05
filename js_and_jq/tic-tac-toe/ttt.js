$(document).ready(function() {

var turns = 0;
var statusArr = [...Array(9).keys()];
var winArr = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[2,5,8],[1,4,7],[0,4,8],[2,4,6]];
var player = "X";
var board = function() {
  $("#boardbox").append("<div class='grid'></div>");
  for (var i = 0; i < 3; ++i){
    $(".grid").append("<div class='row' id='row-"+i+"'></div>");
  }
  for (var j = 0; j < 3; ++j){
    $(".row").append("<div class='square square-"+j+" empty-square'></div>");
  }
}


board();

function makeMove() {
  if ($(this).hasClass('empty-square'))
  {
    turns++;
    var y = Number($(this).attr('class').match(/\d/));
    var x = Number($(this).parent().attr('id').match(/\d/));
    var square = y + (3 * x);
    player = (turns % 2 ? "X" : "O");
    $(this).removeClass("empty-square") && $(this).addClass(player).append("<p>"+player+"</p>");
    statusArr[square] = player;
  }
};

function endGame(cond) {
  switch (cond) {
    case "D":
    console.log("DRAW");
    break;
    default:
    console.log(player + " WINS!");
    $("."+player).addClass("winner");
    cond.forEach(function(e) {
      var c = (e % 3);
      var r = Math.floor(e / 3);
      console.log(c +" "+ r);
      $("#row-"+r).children(".square-"+c).addClass('winning-square');
    })
    break;
  }
}

function gameOverCheck() {
  winArr.forEach(function(entry) {
    if (statusArr[entry[0]] == statusArr[entry[1]] && statusArr[entry[0]] == statusArr[entry[2]]) {
      endGame(entry);
    }
  })
  if (!$(".empty-square").length)
  {
    endGame("D");
  } else {
    return false;
  }
}

$(".square").on('click', function() {
  makeMove.call(event.target);
  gameOverCheck.call(event.target);
});

});
