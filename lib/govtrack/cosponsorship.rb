module GovTrack
  class Cosponsorship < Base

    def initialize(attributes={})
      super
      @joined = Date.parse(@joined) if @joined
    end

    def person
      instantiate_attrs(:@person, GovTrack::Person)
    end

    def bill
      instantiate_attrs(:@bill, GovTrack::Bill)
    end

    def role
      instantiate_attrs(:@role, GovTrack::Role)
    end

  end
end
