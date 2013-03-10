module GovTrack
  class Person < Base

    def initialize(attributes={})
      super
      @birthday = Date.parse(@birthday) if @birthday
    end
    
    def current_role
      # what role do they have in the current congress
      if @current_role
        @current_role.class == GovTrack::Role ? @current_role : @current_role = GovTrack::Role.find_by_id(@current_role['id'])
      else
        # we need to load/find their current role
        @current_role = self.roles.select{|r| r.congress_numbers.include?(CONGRESS)}.sort_by{|o| o.enddate}.reverse.first
        @current_role
      end
    end

    def last_role

    end
    
    def roles
      # this needs to be tested . . . it is probably a hash
      if @roles[0].class == GovTrack::Role
        @roles
      else
        @roles.map! { |role|
          GovTrack::Role.find_by_id(role['id'])
        }
      end
    end
    
  end
end