// myEach() - Tested to work on JSBin

function myEach(arr, callback) {
  for(i = 0; i < arr.length; i++) {
    callback(arr[i]);
  }
});

// myMap() - Tested to work in JSBin
// required modifying myEach to have a return value
// as reflected below:

function myEach(arr, callback) {
  var interim = [];
  for(i = 0; i < arr.length; i++) {
    interim.push(callback(arr[i]));
  }
  return interim;
}

function myMap(arr, callback) {
    var newArray = [];
    newArray.push(myEach(arr, callback));
    return newArray;
}

// myMap() continued

// I don't understand this assignment...
