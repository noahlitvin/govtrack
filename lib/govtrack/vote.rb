module GovTrack
  class Vote < Base

    def initialize(attributes={})
      super
      @created = DateTime.parse(@created) if @created
    end

    def self.find(args)
      #API doesn't allow searching for bill by ID, so query with congress, bill_type, and number.
      if args[:related_bill]
        args[:related_bill__congress] = args[:related_bill].congress
        args[:related_bill__bill_type] = args[:related_bill].bill_type.to_bill_type_number
        args[:related_bill__number] = args[:related_bill].number
        args.delete(:related_bill)
      end
      
      super
    end

    def related_bill
      @related_bill.class == GovTrack::Bill ? @related_bill : @related_bill = GovTrack::Bill.find_by_id(@related_bill['id'])
    end
  
  end
end