module GovTrack
  class Person < Base

    def initialize(attributes={})
      super
      @birthday = Date.parse(@birthday) if @birthday
    end
    
    def roles
      instantiate_attrs(:@roles, GovTrack::Role)
    end
    
  end
end