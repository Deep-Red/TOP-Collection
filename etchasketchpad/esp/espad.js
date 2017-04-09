$(document).ready(function(){
/*	for(var i=0; i<81; i++){
		$('#box').append("<div id='cell' class='cell'></div>");

	}
*/

});


var newGrid = function() {
		var length = document.getElementById("length").value
		var area = length * length
		$('.wrapper').empty();
		for(var i=0; i < area; i++){
			$('#box').append("<div id='cell' class='cell'></div>");
		};
		var boardLength = ((550 / length) - (2)) //document.getElementById("box").offsetHeight
		$('.cell').css('width', boardLength);
		$('.cell').css('height', boardLength);

	$('.cell').hover(function(){
	
	var color = $(this).css('background-color');
	var regExp = /\(([^)]+)\)/;  // get the values within ()
	var matches = regExp.exec(color);
	var splits = matches[1].split(',');
	//alert("red: " + splits[0] + "green: " + splits[1]+ "blue: "+ splits[2] );

	var r = splits[0];
	var g = splits[1];
	var b = splits[2];

	if(r < 256 && g < 256 && b < 256){
		var d3 = Math.floor((Math.random() * 3))
		if(d3 === 0){
	r += Math.floor((Math.random() * 2));
}
		else if(d3 === 1){
	g += Math.floor((Math.random() * 2));
}
		else{
	b += Math.floor((Math.random() * 2));
}
	$(this).css('background-color', 'rgb(' + r + ',' + g + ',' + b + ')');
	} 
})


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