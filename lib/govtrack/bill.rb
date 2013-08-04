module GovTrack
  class Bill < Base

    def initialize(attributes={})
      super
      @introduced_date = Date.parse(@introduced_date) if @introduced_date
      @current_status_date = Date.parse(@current_status_date) if @current_status_date
    end

    def sponsor
      @sponsor.class == GovTrack::Person ? @sponsor : @sponsor = GovTrack::Person.find_by_id(@sponsor['id'])
    end
    
    def cosponsors
      if @cosponsors[0].class == GovTrack::Person 
        @cosponsors
      else
        @cosponsors.map! { |cosponsor_obj|
          GovTrack::Person.new(cosponsor_obj)
        }
      end
    end
  
  end
end