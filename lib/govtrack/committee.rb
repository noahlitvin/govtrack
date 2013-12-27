module GovTrack
  class Committee < Base

    def subcommittee?
      !committee.nil?
    end

    def committee
      return nil if !@committee
      @committee.is_a?(GovTrack::Committee) ? @committee : @committee = GovTrack::Committee.new(@committee)
    end
  end
end
