module GovTrack
  class CommitteeMember < Base

    def committee
      @committee.is_a?(GovTrack::Committee) ? @committee : GovTrack::Committee.find_by_id(@committee['id'])
    end

    def person
      @person.is_a?(GovTrack::Person) ? @person : @GovTrack::Person.find_by_id(@person['id'])
    end

    def self.demodulized_name
      'committee_member'
    end
  end
end
