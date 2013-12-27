module GovTrack
  class Committee < Base

    def subcommittee?
      !committee.nil?
    end
  end
end
