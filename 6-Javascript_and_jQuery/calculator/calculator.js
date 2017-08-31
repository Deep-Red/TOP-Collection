var inputArr = [];

function add(a,b) {
  return a + b;
}

function multiply(a,b) {
  return (a * b);
}

function divide(a,b) {
  return (a / b);
}

function subtract(a,b) {
  return (a - b);
}

function mathify(nums, ops) {
  switch (ops.shift().charCodeAt(0)) {
    case 43:
    left = nums.shift();
    right = nums.shift();
    console.log(add(left, right));
    break;

    case 45:
    left = nums.shift();
    right = nums.shift();
    console.log(subtract(left, right));
    break;

    case 247:
    left = nums.shift();
    right = nums.shift();
    console.log(divide(left, right));
    break;

    case 215:
    left = nums.shift();
    right = nums.shift();
    console.log(multiply(left, right));
    break;

    default:
    console.log("the case is: ");

  }
}

$( document ).ready(function() {
$(".button").click(function() {
  var inputKey = $(event.target).text();
  var numberBuilder = [];
  var numbers  = [];
  var operations = [];
  switch (inputKey) {
    case "C":
      inputArr = [];
      break;
    case "=":
      inputArr.push("=");
      for (i = 0; i < inputArr.length; i++) {
        if (/\d/.test(inputArr[i]) || inputArr[i] === ".") {
          numberBuilder.push(inputArr[i]);
        } else {
          operations.push(inputArr[i]);
          tempNumber = numberBuilder.join("");
          tempNumber = parseFloat(tempNumber);
          numbers.push(tempNumber);
          numberBuilder = [];
          console.log("Numbers: " + numbers + "operations: " + operations );
        }
      }
      operations.pop();
      mathify(numbers, operations);
      inputArr = [];
      break;
    default:
      inputArr.push(inputKey);
      console.log(inputKey);
      console.log(inputArr);
      console.log("AA" +inputKey.charCodeAt(0));
      break;
  }

});
});
