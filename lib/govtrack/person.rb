module GovTrack
  class Person < Base

    # only filterable:
    # lastname, gender

    def initialize(attributes={})
      super
      @birthday = Date.parse(@birthday) if @birthday
      # if roles do not exist (from a query like "http://www.govtrack.us/api/v2/person/?limit=10"
      # then we need to look up the user to get them
      #if @roles.nil?
      #
      #else
      #end
    end
    
    def current_role
      # what role do they have in the current congress
      if @current_role
        @current_role.class == GovTrack::Role ? @current_role : @current_role = GovTrack::Role.find_by_id(@current_role['id'])
      else
        # we need to load/find their current role
        #if self.roles.select{|r| r.congress_numbers.
        unless @roles # then rolls are defined
          @roles = GovTrack::Person.find_by_id(self.id).roles
        end
        if @roles.first.is_a?(Hash)
          unless (current_role = @roles.select{|r| r['current'] == true}).empty?
            @current_role = GovTrack::Role.find_by_id(current_role.first['id'])
          end
        else
          @current_role = @roles.select{|r| r.current == true}.first
        end

        @current_role
      end
    end

    def last_role
      # pending
    end
    
    def roles
      instantiate_attrs(:@roles, GovTrack::Role)
    end
    
  end
end