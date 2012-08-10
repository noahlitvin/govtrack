module GovTrack
  class Role < Base

    def initialize(attributes={})
      super
      @startdate = Date.parse(@startdate) if @startdate
      @enddate = Date.parse(@enddate) if @enddate
    end
    
  end
end