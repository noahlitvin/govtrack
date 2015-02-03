module GovTrack
  class VoteVoter < Base

    def initialize(attributes={})
      super
      @created = DateTime.parse(@created) if @created
    end

    def self.find(args)
      #allows searching with Person and Vote objects
      args.each { |k,v|
        args[k] = v.id  if [GovTrack::Person, GovTrack::Vote, GovTrack::PaginatedList].include?(v.class)
      }
      super
    end

    def self.demodulized_name
     "vote_voter"
    end
    
    def person
      instantiate_attrs(:@person, GovTrack::Person)
    end
    
    def vote
      instantiate_attrs(:@vote, GovTrack::Vote)
    end

    def vote_direction
      # the direction voted in: "Yes", "No", etc.
      @option['value']
    end

  end
end