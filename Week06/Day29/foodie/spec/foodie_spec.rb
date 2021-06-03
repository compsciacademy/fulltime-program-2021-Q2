require 'foodie'

describe Foodie::Food do
    it "broccoli is gross" do
        expect(Foodie::Food.portray("Broccoli")).to eq("Gross!")
    end

    it "anything else is delicious" do
        expect(Foodie::Food.portray("Not Broccoli")).to eq("Delicious!")
    end
end
