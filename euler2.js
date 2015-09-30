var a = 1
var b = 2

var isEven = function(b){
	if(b % 2 === 0){
		return b;
	}
	else{
		return 0;
	}
}

var findFib = function(){
	var input = document.getElementById("problem_2_input").value;
	var answer2 = document.getElementById("answer2");
	var c = 0
	if(input <= 4000000){
	for(a = 1; a < input; (a += b)){
		a += isEven(a);


	}
	answer2.innerHTML = a;
}
	else{
	answer2.innerHTML = "Pick a Number less than 4000000!"
	}
};
