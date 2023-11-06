class Museum
    attr_reader :name, :exhibits, :patrons

    def initialize(name)
        @name = name
        @exhibits = []
        @patrons = []
    end

    def add_exhibit(exhibit)
        @exhibits << exhibit
    end

    def recommend_exhibits(patron)
        recommended_exhibits = []
        patron.interests.map do |interest|
            @exhibits.map do |exhibit|
                if exhibit.name.downcase == interest.downcase
                    recommended_exhibits << exhibit
                end
            end
        end
        recommended_exhibits
    end

    def admit(patron)
        @patrons << patron
    end
end