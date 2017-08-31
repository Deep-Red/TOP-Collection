require "caesar_cypher"

describe "caesar_cypher" do

	it "shifts a letter by a given key" do
		expect(caesar_cypher("a", 1)).to eql("b")
	end

	it "shifts a word by a given key" do
		expect(caesar_cypher("hello", 2)).to eql("jgnnq")
	end

	it "preserves white spaces" do
		expect(caesar_cypher("hi you", 1)).to eql("ij zpv")
	end

	it "preserves special characters and capitalization" do
		expect(caesar_cypher("Hi There!", 3)).to eql("Kl Wkhuh!")
	end

	it "shifts z to a and Z to A" do
		expect(caesar_cypher("Zz", 2)).to eql("Bb")
	end

end