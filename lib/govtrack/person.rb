module GovTrack
  class Person < Base

    def initialize(attributes={})
      super
      @birthday = Date.parse(@birthday) if @birthday
    end
    
    def roles
      if @roles[0].class == GovTrack::Role
        @roles
      else
        @roles.map! { |role_obj|
          GovTrack::Role.new(role_obj)
        }
      end
    end
    
  end
end