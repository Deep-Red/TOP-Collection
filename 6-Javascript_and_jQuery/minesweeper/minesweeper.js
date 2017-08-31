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
//    console.log("i" + cells);
  }
  for (var j = 0; j < rows; j++) {
    for(var k = 0; k < cols; k++) {
      $('#row-'+j).append("<div class='cell' id='cell-"+j+"-"+k+"'></div>");
      cells[j].push(new Cell(false, false, j, k));
    }
  }
//  console.log(cells);
}

var setMines = function(count) {
  for (i = 0; i < count; i++) {
    r = Math.floor(Math.random() * height);
    c = Math.floor(Math.random() * width);
    cells[r][c].mined = true;
//    console.log(r+"-"+c);

    $('#cell-'+r+"-"+c).addClass('mined');
    if (c < 8) {
      cells[r][(c+1)].touching++;
//      $('#cell-'+(r)+"-"+(c+1)).addClass('flagged');

      if (r < 8) {
        cells[(r+1)][(c+1)].touching++;
//        $('#cell-'+(r+1)+"-"+(c+1)).addClass('flagged');

      }
      if (r > 0) {
        cells[(r-1)][(c+1)].touching++;
//        $('#cell-'+(r-1)+"-"+(c+1)).addClass('flagged');

      }
    }
    if (c > 0) {
      cells[r][(c-1)].touching++;
//      $('#cell-'+(r)+"-"+(c-1)).addClass('flagged');

      if (r < 8) {
        cells[r+1][(c-1)].touching++;
//        $('#cell-'+(r+1)+"-"+(c-1)).addClass('flagged');

      }
      if (r > 0) {
        cells[(r-1)][(c-1)].touching++;
//        $('#cell-'+(r-1)+"-"+(c-1)).addClass('flagged');

      }
    }
    if (r < 8) {
      cells[r+1][(c)].touching++;
//      $('#cell-'+(r+1)+"-"+(c)).addClass('flagged');

    }
    if (r > 0) {
      cells[(r-1)][c].touching++;
//      $('#cell-'+(r-1)+"-"+(c)).addClass('flagged');

    }

  }
}

var toggleFlag = function () {
  r = event.target.id.split("-")[1];
  c = event.target.id.split("-")[2];
  cells[r][c].flagged = !cells[r][c].flagged;
  $(this).toggleClass('flagged');
}
var boom = function () {
  console.log("Boom");
  $('.mined').addClass('exploded');
}

var height = Number($('#rowinput').value) || 9;
var width = Number($('#colinput').value) || 9;
var mines = Number($('#mininput').value) || 9;
var board = new Board(height, width, mines);
setMines(mines);

console.log($('#rowinput'));
console.log($('#rowinput').value);
console.log($('#rowinput')[0]);
console.log(height);
console.log($('form').serialize());
var formData = new FormData(document.querySelector('form'));
console.log(formData);
var formnumber = document.getElementsByName("rows").value;
console.log(formnumber);

$('#minefield').one('click', function() {
  start = Date.now();
  setInterval(function() {
    minutes = Math.floor((new Date - start) / 1000 / 60, 1000);
    secint = Math.round((new Date - start) / 1000 % 60, 1000);
    seconds = ("0" + secint).slice(-2);
    $('.timer').text(minutes + ":" + seconds);
  }, 1000);
});
$('.cell').on('click', function() {
  if (!$(this).hasClass('clicked')) {
    $(this).addClass('clicked');
//    console.log("Clicked on "+$(this)[0].id);
    var r = Number($(this)[0].id.split("-")[1]);
    var c = Number($(this)[0].id.split("-")[2]);
    console.log("c, r:"+ c+ ""+r);
//    console.log($(this)[0].id + event.which);
    if (cells[r][c].mined) {
      boom.call($(this));
    } else if ((cells[r][c].touching) > 0) {
      $(this).append("<p>"+cells[r][c].touching+"</p>");
    } else {
      for (i = -1; i < 2; i++) {
        for (j = -1; j < 2; j++) {
          $('#cell-'+(r+i)+"-"+(c+j)).click();
        }
      }
//      console.log('#cell-'+r+'-'+(c+1));
//      $('#cell-'+r+"-"+(c+1)[0]).click();
//      console.log("AAAAAAAAAAAA");
//      $('#cell-'+r+"-"+(c-1)[0]).click();
//      $('#cell-'+(r+1)+"-"+c[0]).click();
//      $('#cell-'+(r+1)+"-"+(c-1)[0]).click();
//      console.log("BBBBBBBBBBBB");
//      $('#cell-'+(r+1)+"-"+(c+1)[0]).click();
//      $('#cell-'+(r-1)+"-"+c[0]).click();
//      $('#cell-'+(r-1)+"-"+(c-1)[0]).click();0
//      console.log($('#cell-'+(r-1)+"-"+(c+1)[0]).click());
//      console.log("CCCCCCCCCCCC");
    }
  }
});
$('.cell').on('contextmenu', function(){
  event.preventDefault();
  toggleFlag.call($(this));
//  console.log(($('.mined').not('.flagged').length));
//  console.log(($('.flagged').not('.mined').length));
  if (($('.mined').not('.flagged').length === 0) && ($('.flagged').not('.mined').length === 0)) {
    console.log("YOU WIN");
  }
})


});
