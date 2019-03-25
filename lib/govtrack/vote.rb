module GovTrack
  class Vote < Base

    def initialize(attributes={})
      super
      @created = DateTime.parse(@created) if @created
    end

    def related_bill
      @related_bill.class == GovTrack::Bill ? @related_bill : @related_bill = GovTrack::Bill.find_by_id(@related_bill['id'])
    end
  
  end
end