module GovTrack
  class PaginatedList < ::Array
    
    attr_reader :limit, :offset, :total
    
    def initialize(object_class,meta,objects)
      if meta
        @limit = meta['limit']
        @offset = meta['offset']
        @total = meta['total_count']
      end

      super((objects || []).map { |object| object_class.new(object) })
    end

    def method_missing(method_id, *arguments)
      #passes methods through to item when list contains only one
      if self.length == 1 
        self.first.send(method_id, *arguments)
      else
        super
      end
    end

  end
end