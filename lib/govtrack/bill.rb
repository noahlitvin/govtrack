module GovTrack
  class Bill < Base

    def initialize(attributes={})
      super
      @introduced_date = Date.parse(@introduced_date) if @introduced_date
      @current_status_date = Date.parse(@current_status_date) if @current_status_date
    end

    def self.find(args)
      args[:bill_type] = args[:bill_type].to_bill_type_number if args[:bill_type]
      args[:current_status] = args[:current_status].to_current_status_number if args[:current_status]
      super
    end

    def sponsor
      @sponsor.class == GovTrack::Person ? @sponsor : @sponsor = GovTrack::Person.find_by_id(@sponsor['id'])
    end
    
    def cosponsors
      if @cosponsors[0].class == GovTrack::Person 
        @cosponsors
      else
        @cosponsors.map! { |cosponsor_uri|
          GovTrack::Person.find_by_uri(cosponsor_uri)
        }
      end
    end
  
  end
end