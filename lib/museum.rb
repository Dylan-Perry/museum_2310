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

    def patrons_by_exhibit_interest
        exhibit_interest_hash = {}
        @exhibits.map do |exhibit|
            exhibit_patrons_array = []
            @patrons.map do |patron|
                if recommend_exhibits(patron).include?(exhibit)
                    exhibit_patrons_array << patron
                end
            end
            exhibit_interest_hash[exhibit] = exhibit_patrons_array
        end
        exhibit_interest_hash
    end

    def ticket_lottery_contestants(exhibit)
        potential_contestants_array = patrons_by_exhibit_interest[exhibit]
        contestants_array = []
        potential_contestants_array.map do |contestant|
            if contestant.spending_money < exhibit.cost
                contestants_array << contestant
            end
        end
        contestants_array
    end
end