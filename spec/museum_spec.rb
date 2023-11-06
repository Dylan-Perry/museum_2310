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
end