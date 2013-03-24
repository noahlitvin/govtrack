module GovTrack
  class Bill < Base

    def initialize(attributes={})
      super
      @introduced_date = Date.parse(@introduced_date) if @introduced_date
      @current_status_date = Date.parse(@current_status_date) if @current_status_date
      # maybe get cosponsors working here . . .
    end

    def self.find(args)
      args[:bill_type] = args[:bill_type].to_bill_type_number if args[:bill_type]
      #args[:current_status] = args[:current_status].to_current_status_number if args[:current_status]
      # these are no longer integers on the api
      super
    end

    def sponsor
      if @sponsor.class == Hash
        @sponsor = GovTrack::Person.find_by_id(@sponsor['id'])
      end
      @sponsor
    end
    
    def cosponsors
      # check to see if cosponsors returns a Person, otherwise,
      # in this case, the model now has a cosponsor that returns a hash . . .
      if @cosponsors[0].class == GovTrack::Person 
        @cosponsors
      elsif @cosponsors[0].is_a?(Hash)  # change for v2
        @cosponsors.map! do |cosponsor_url|
          GovTrack::Person.find_by_id(cosponsor_url['id'])
        end
      else
        @cosponsors.map! { |cosponsor_uri|
          GovTrack::Person.find_by_uri(cosponsor_uri)
        }
      end
    end
  
  end
end