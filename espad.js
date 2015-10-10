$(document).ready(
	function makeDivs(len){
		var e = document.body;
		var len = 16
		for(var y=0; y < len; y++){
			var row = document.createElement("div");
		}
		row.className="row";

		for(var x=1; x < len; x++){
			var cell = document.createElement("div");
		}
		cell.className="gridsquare";
		cell.innerText="(y * len) + x";
		row.appendChild(cell);
	
	e.appendChild(row);

document.getElementById("box").innerText = e.innerHTML;
});