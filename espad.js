/*$(document).ready(
*/

	var newGrid = function() {
		var length = document.getElementById("length").value
		var area = length * length
		$('.wrapper').empty();
		for(var i=0; i < area; i++){
			$('#box').append("<div id='cell' class='cell'></div>");
		};
		var boardLength = document.getElementById("box").offsetHeight
		$('cell').css('width', boardLength);
		$('cell').css('height', boardLength);

	}

/*
	function makeRow() {
		var $row = $("<div id='row' class='row' />")
		for(var y=0; y<16; y++){
			$("#box").append($row);
		}
	}
*/

/*	function makeCell(){
		var $cell = $("<div id='cell1' class='cell1' />")
		$("#box").append($cell);
*/

/*	function makeDivs(len){
		var e = document.body;
		var len = 16
		var $newDiv1 = $("<div id='newDiv1' class='row' />")
		var $newDiv2 = $("<div id='newDiv2' class='gridsquare' />");
		for(var y=0; y < len; y++){
			$("box").append($newDiv1);
		}
		
		for(var x=1; x < len; x++){
			$("row").append($newDiv2);
		}
		

document.getElementById("box").innerText = e.innerHTML;
}

);
*/