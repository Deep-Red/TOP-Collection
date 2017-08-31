function my_max(arr) {
  var max = arr[0];
  for (var i = 0; i < arr.length; i ++) {
    max = (max > arr[i]) ? max : arr[i];
  }
  return max;
}

function vowel_count(str) {
  var m = str.match(/[aeiou]/gi);
  return m === null ? 0 : m.length;
}

function reverse(str) {
	old_str = str.split("");
  new_str = [];
  for (i = 0; i < str.length; i++) {
  new_str.push(old_str.pop());
  }
  return new_str;
}
