module GovTrack
  class CommitteeMember < Base

    def committee
      instantiate_attrs(:@committee, GovTrack::Committee)
    end

    def person
      instantiate_attrs(:@person, GovTrack::Person)
    end

    def self.demodulized_name
      'committee_member'
    end
  end
end
