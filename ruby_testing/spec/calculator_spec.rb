require "./lib/calculator"

describe Calculator do
  describe "#add" do
    it "returns sum of some numbers" do
      calculator = Calculator.new
      expect(calculator.add(3, 4, 10)).to eql(17)
    end
  end

  describe "#multiply" do
    it "returns result of multipying some number" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 5, 6)).to eql(60)
    end
  end

  describe "#devide" do
    it "returns division of first by second number" do
      calcultor = Calculator.new
      expect(calcultor.devide(30, 6)).to eql(5)
    end
  end
end
