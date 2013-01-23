module GovTrack
  class Person < Base

    def initialize(attributes={})
      super
      @birthday = Date.parse(@birthday) if @birthday
    end
    
    def current_role
      if @current_role
        @current_role.class == GovTrack::Role ? @current_role : @current_role = GovTrack::Role.find_by_id(@current_role['id'])
      else
        puts "no current role for #{@name} !!!!!! error !!!!!"
        nil
      end
    end
    
    def roles
      if @roles[0].class == GovTrack::Role
        @roles
      else
        @roles.map! { |role_uri|
          GovTrack::Role.find_by_uri(role_uri)
        }
      end
    end
    
  end
end