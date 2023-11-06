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

    describe "#adds_exhibit and #recommend_exhibits" do
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

        it "recommends exhibits based on patron interests" do
            dmns = Museum.new("Denver Museum of Nature and Science")
            gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
            dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
            imax = Exhibit.new({name: "IMAX",cost: 15})

            dmns.add_exhibit(gems_and_minerals)
            dmns.add_exhibit(dead_sea_scrolls)
            dmns.add_exhibit(imax)

            patron_1 = Patron.new("Bob", 20)
            patron_1.add_interest("Dead Sea Scrolls")
            patron_1.add_interest("Gems and Minerals")

            patron_2 = Patron.new("Sally", 20)
            patron_2.add_interest("IMAX")
            
            expect(dmns.recommend_exhibits(patron_1)).to eq([dead_sea_scrolls, gems_and_minerals])
            expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
        end
    end

    describe "#admit, #patrons_by_exhibit_interest, #ticket_lottery_contestants, #draw_lottery_winner, #announce_lottery_winner" do
        it "admits patrons" do
            dmns = Museum.new("Denver Museum of Nature and Science")

            patron_1 = Patron.new("Bob", 20)
            patron_1.add_interest("Dead Sea Scrolls")
            patron_1.add_interest("Gems and Minerals")

            patron_2 = Patron.new("Sally", 20)
            patron_2.add_interest("IMAX")

            patron_3 = Patron.new("Johnny", 5)
            patron_3.add_interest("Dead Sea Scrolls")

            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
        end

        it "lists patrons by exhibit interest" do
            dmns = Museum.new("Denver Museum of Nature and Science")
            gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
            dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
            imax = Exhibit.new({name: "IMAX",cost: 15})

            dmns.add_exhibit(gems_and_minerals)
            dmns.add_exhibit(dead_sea_scrolls)
            dmns.add_exhibit(imax)

            patron_1 = Patron.new("Bob", 20)
            patron_1.add_interest("Dead Sea Scrolls")
            patron_1.add_interest("Gems and Minerals")

            patron_2 = Patron.new("Sally", 20)
            patron_2.add_interest("IMAX")

            patron_3 = Patron.new("Johnny", 5)
            patron_3.add_interest("Dead Sea Scrolls")

            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expect(dmns.patrons_by_exhibit_interest).to eq({gems_and_minerals=>[patron_1], dead_sea_scrolls=>[patron_1, patron_3], imax=>[patron_2]})
        end

        it "returns an array of patrons that can't afford an exhibit, but are interested in the exhibit" do
            dmns = Museum.new("Denver Museum of Nature and Science")
            gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
            dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
            imax = Exhibit.new({name: "IMAX",cost: 15})

            dmns.add_exhibit(gems_and_minerals)
            dmns.add_exhibit(dead_sea_scrolls)
            dmns.add_exhibit(imax)

            patron_1 = Patron.new("Bob", 0)
            patron_1.add_interest("Dead Sea Scrolls")
            patron_1.add_interest("Gems and Minerals")

            patron_2 = Patron.new("Sally", 20)
            patron_2.add_interest("IMAX")

            patron_3 = Patron.new("Johnny", 5)
            patron_3.add_interest("Dead Sea Scrolls")

            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])
            expect(dmns.ticket_lottery_contestants(imax)).to eq([])
        end

        it "draws a lottery winner given an exhibit" do
            dmns = Museum.new("Denver Museum of Nature and Science")
            gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
            dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
            imax = Exhibit.new({name: "IMAX",cost: 15})

            dmns.add_exhibit(gems_and_minerals)
            dmns.add_exhibit(dead_sea_scrolls)
            dmns.add_exhibit(imax)

            patron_1 = Patron.new("Bob", 0)
            patron_1.add_interest("Dead Sea Scrolls")
            patron_1.add_interest("Gems and Minerals")

            patron_2 = Patron.new("Sally", 20)
            patron_2.add_interest("IMAX")

            patron_3 = Patron.new("Johnny", 5)
            patron_3.add_interest("Dead Sea Scrolls")

            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expect(dmns.draw_lottery_winner(dead_sea_scrolls)).to eq(patron_1 || patron_3)
            expect(dmns.draw_lottery_winner(gems_and_minerals)).to eq(nil)
        end
    end
end