module GovTrack
  class Committee < Base

    def subcommittee?
      !committee.nil?
    end

    def committee
      return nil if !@committee
      instantiate_attrs(:@committee, GovTrack::Committee)
    end
  end
end
