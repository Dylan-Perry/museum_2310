require "./lib/patron"

describe Patron do
    it "exists" do
        patron = Patron.new

        expect(patron).to be_a Patron
    end
end