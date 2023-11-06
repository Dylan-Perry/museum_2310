require "./lib/patron"

describe Patron do
    it "exists" do
        patron_1 = Patron.new("Bob", 20)

        expect(patron_1).to be_a Patron
    end

    it "stores and reads name, spending money, and interests attributes" do
        patron_1 = Patron.new("Bob", 20)

        expect(patron_1.name).to eq("Bob")
        expect(patron_1.spending_money).to eq(20)
        expect(patron_1.interests).to eq([])
    end

    it "adds interests" do
        patron_1 = Patron.new("Bob", 20)
        patron_1.add_interest("Dead Sea Scrolls")

        expect(patron_1.interests).to eq(["Dead Sea Scrolls"])

        patron_1.add_interest("Gems and Minerals")
        
        expect(patron_1.interests).to eq(["Dead Sea Scrolls", "Gems and Minerals"])
    end
end