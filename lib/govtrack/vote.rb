module GovTrack
  class Vote < Base

    def initialize(attributes={})
      super
      @created = DateTime.parse(@created) if @created
    end

    def related_bill
      instantiate_attrs(:@related_bill, GovTrack::Bill)
    end
  
  end
end