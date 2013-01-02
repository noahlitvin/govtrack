module GovTrack
  class Base
    include HTTParty

    base_uri 'http://www.govtrack.us/api/v1'
    
    def initialize(attributes=nil)
      attributes ||= {}
      attributes.each do |(attr, val)|
        instance_variable_set("@#{attr}", val)
        instance_eval "def #{attr}() @#{attr} end" unless self.respond_to?(attr)
      end
    end

    def self.find(args)
      args[:limit] ||= 500 if block_given? #default to queries of 500 when a block is given
      
      response = get("/#{self.demodulized_name}/?#{URI.escape(URI.encode_www_form(args))}")
      paginated_list = GovTrack::PaginatedList.new(self,response["meta"],response["objects"])
      
      if block_given?
        page = paginated_list.offset
        for page in paginated_list.offset..(paginated_list.total/paginated_list.limit)
          args[:offset] = page
          if page == (paginated_list.total/paginated_list.limit).to_i #don't supply the end of the last page
            self.find(args).first(paginated_list.total%paginated_list.limit).each { |item| yield item }
          else
            self.find(args).each { |item| yield item }
          end
        end
      else
        paginated_list
      end
    end

    def self.find_by_id(id)
      puts "/#{self.demodulized_name}/#{id}"
      new(get("/#{self.demodulized_name}/#{id}"))
    end

    def self.find_by_uri(uri)
      new(get("http://www.govtrack.us#{uri}"))
    end

    def ==(other)
      other.equal?(self) || (other.instance_of?(self.class) && other.id == id)
    end

    def eql?(other)
      self == other
    end

    def self.method_missing(method_id, *arguments)
      #generates dynamic find_by methods, ActiveRecord style.
      if method_id.to_s =~ /^find_by_([_a-zA-Z]\w*)$/
        attribute_names = $1.split '_and_'
        conditions = {}
        attribute_names.each_with_index do |name,index|
          conditions[name.to_sym] = arguments[index]
        end
        self.find(conditions)
      else
        super
      end
    end
  
  protected
  
  def self.demodulized_name
    self.name.split('::').last.downcase == "votevoter" ? "vote_voter" : self.name.split('::').last.downcase 
  end

  end
end