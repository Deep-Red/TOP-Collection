var fibUpTo = function(b){
	var i1 = 1;
	var i2 = 0;
	var sumOfEvens = 0;
	var temp = 0;
	while (i1 <= b){
		if(i1 % 2 === 0){
		sumOfEvens += i1;
	}
	temp = i1;
	i1 = i2;
	i2 = (temp + i2);
}
return sumOfEvens;
};

var findFib = function(){
	var input = document.getElementById("problem_2_input").value;
	var answer2 = document.getElementById("answer2");
	if (input <= 4000000){
	var c = fibUpTo(input);
	answer2.innerHTML = c;
}

	else{
	answer2.innerHTML = "Pick a Number less than 4000000!";
	}
};
