require "./lib/museum"
require "./lib/patron"
require "./lib/exhibit"

describe Museum do
    it "exists" do
        dmns = Museum.new("Denver Museum of Nature and Science")

        expect(dmns).to be_a Museum
    end

    it "stores and reads name, and creates empty exhibits array" do
        dmns = Museum.new("Denver Museum of Nature and Science")

        expect(dmns.name).to eq("Denver Museum of Nature and Science")
        expect(dmns.exhibits).to eq ([])
    end

    describe "#adds_exhibit and #recommend_exhibit" do
        before :each do
            dmns = Museum.new("Denver Museum of Nature and Science")
            gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
            dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
            imax = Exhibit.new({name: "IMAX",cost: 15})

            patron_1 = Patron.new("Bob", 20)
            patron_1.add_interest("Dead Sea Scrolls")
            patron_1.add_interest("Gems and Minerals")

            patron_2 = Patron.new("Sally", 20)
            patron_2.add_interest("IMAX")
        end

        it "adds exhibits" do
            dmns = Museum.new("Denver Museum of Nature and Science")
            gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
            dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
            imax = Exhibit.new({name: "IMAX",cost: 15})
    
            dmns.add_exhibit(gems_and_minerals)
            dmns.add_exhibit(dead_sea_scrolls)
            dmns.add_exhibit(imax)
    
            expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
        end
        
    end
end