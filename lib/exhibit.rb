class Exhibit
    attr_reader :name, :cost

    def initialize(exhibit_hash)
        @name = exhibit_hash[:name]
        @cost = exhibit_hash[:cost]
    end
end