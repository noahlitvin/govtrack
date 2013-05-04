module GovTrack
  class VoteVoter < Base

    def initialize(attributes={})
      super
      @created = DateTime.parse(@created) if @created
    end

    def self.find(args)
      #allows searching with Person and Vote objects
      args.each { |k,v|
        args[k] = v.id  if v.class == GovTrack::Person || v.class == GovTrack::Vote || v.class == GovTrack::PaginatedList
      }
      super
    end
    
    def person
      if @person.is_a?(Hash)
        @person = GovTrack::Person.find_by_id(@person['id'])
      else
        @person.class == GovTrack::Person ? @person : @person = GovTrack::Person.find_by_uri(@person)
      end
    end
    
    def vote
      if @vote.is_a?(Hash)
          @vote = GovTrack::Vote.find_by_id(@vote['id'])
        else
          @vote.class == GovTrack::Vote ? @vote : @vote = GovTrack::Vote.find_by_uri(@vote)
      end
    end

    def vote_description
      "#{person.sortname} voted #{option["value"]} on #{vote.related_bill.title}"
    end

  end
end