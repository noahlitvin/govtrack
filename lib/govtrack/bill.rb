module GovTrack
  class Bill < Base

    def initialize(attributes={})
      super
      @introduced_date = Date.parse(@introduced_date) if @introduced_date
      @current_status_date = Date.parse(@current_status_date) if @current_status_date
    end

    def self.find(args)
      # might not be necessary
      args[:bill_type] = args[:bill_type].to_bill_type_number if args[:bill_type]
      #args[:current_status] = args[:current_status].to_current_status_number if args[:current_status]
      # these are no longer integers on the api
      super
    end

    def sponsor
      instantiate_attrs(:@sponsor, GovTrack::Person)
    end
    
    def cosponsors
      instantiate_attrs(:@cosponsors, GovTrack::Person)
    end
    
    def committees
      instantiate_attrs(:@committees, GovTrack::Committee)
    end
  
  end
end