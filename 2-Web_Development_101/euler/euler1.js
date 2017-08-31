var isMultiple = function(number){
if ((number % 3 === 0) || (number % 5 === 0)) {
    return number;
}
    else {
        return 0;
    }
};

var sumOfMultiples = function(){
    var input = document.getElementById("problem_1_input").value;
    var answer = document.getElementById("answer");
    var sum = 0
    for(var i = 1; i < input; i++){
        sum += isMultiple(i);
    }
    answer.innerHTML = sum;
};
