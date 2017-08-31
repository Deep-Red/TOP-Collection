require "enumerable_methods"

describe"enumerable_methods" do

	let my_arr1 = [2, 3, 5, 6, 17, 9]
	let my_arr2 = ["hi", "there", "my", "friend"]
	let my_arr3 = [3, "mix", 11, "it", "up"]

	describe ".my_count" do
		expect(my_arr3.count()).to eql(5)
		expect(my_arr2.count()).to eql(4)
		expect(my_arr1.count()).to eql(6)
	end

end