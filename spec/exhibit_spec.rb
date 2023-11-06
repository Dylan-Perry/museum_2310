require "./lib/exhibit"

describe Exhibit do
    it "exists" do
        exhibit = Exhibit.new

        expect(exhibit).to be_a Exhibit
    end
end