// Bianca Gandolfo's callbackExercises
// https://github.com/bgando/functionalJS/blob/master/callbacks/callbackExercises.md

function funcCaller(arg, func) {
  return func(arg);
}

function firstVal(arr, func) {
  func(arr[0], 0, arr);
}

function firstVal(obj, func) {
  if(Array.isArray(obj)) {
    func(obj[0], 0, obj);
  } else {
    var keys = Object.keys(obj);
    func(keys[0], 0, obj);
  }
}


// Incomplete solution to Extra Credit
// I understand that the concept is to set a boolean flag
// A better solution may be to reassign the function itself once it
// has been called once.
function _.once(function() {
  var executed = false;
  return function() {
    if (!executed) {
      executed = true;

    }
  }
}
