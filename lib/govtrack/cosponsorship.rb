module GovTrack
  class Cosponsorship < Base

    def initialize(attributes={})
      super
      @joined = Date.parse(@joined) if @joined
    end

    def person
      @person.is_a?(GovTrack::Person) ? @person : @person = GovTrack::Person.find_by_id(@person)
    end

    def bill
      @bill.is_a?(GovTrack::Bill) ? @bill : @bill = GovTrack::Bill.find_by_id(@bill)
    end

    def role
      @role.is_a?(GovTrack::Role) ? @role : @role = GovTrack::Role.find_by_id(@role)
    end

  end
end
