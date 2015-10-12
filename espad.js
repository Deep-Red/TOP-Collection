$(document).ready(
	function makeDivs(len){
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
});