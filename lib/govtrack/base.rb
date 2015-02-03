module GovTrack
  class Base
    include HTTParty

    base_uri 'http://www.govtrack.us/api/v2'
    
    def initialize(attributes={})
      attributes.each do |(attr, val)|
        attr = attr.gsub('-', '_') # dashes not allowed in instance variable names
        instance_variable_set("@#{attr}", val)
        instance_eval "def #{attr}() @#{attr} end" unless self.respond_to?(attr)
      end
    end

    def ==(other)
      other.equal?(self) || (other.instance_of?(self.class) && other.id == id)
    end

    def eql?(other)
      self == other
    end

    def self.find(args)
      args[:limit] ||= 500 if block_given? #default to queries of 500 when a block is given
      
      response = get("/#{self.demodulized_name}/?#{URI.escape(URI.encode_www_form(args))}")
      puts "requesting: #{base_uri}/#{self.demodulized_name}/#{URI.escape(URI.encode_www_form(args))}"
      paginated_list = GovTrack::PaginatedList.new(self,response["meta"],response["objects"])
      
      if block_given?
        offset = paginated_list.offset
        limit  = paginated_list.limit
        total  = paginated_list.total

        for page in offset..(total/limit)
          args[:offset] = page
          if page == (total/limit).to_i #don't supply the end of the last page
            self.find(args).first(total % limit).each { |item| yield item }
          else
            self.find(args).each { |item| yield item }
          end
        end
      else
        paginated_list
      end
    end

    def self.find_by_id(id)
      new(get("/#{self.demodulized_name}/#{id}"))
    end

    def self.find_by_uri(uri)
      new(get("http://www.govtrack.us#{uri}"))
    end
  
    private

    def instantiate_attrs(var, klass)
      # turn attributes into GovTrack objects if still in JSON format
      val = instance_variable_get(var)
      if val.is_a?(klass)
        return val
      elsif val.is_a?(Hash)
       instance_variable_set(var, klass.find_by_id(val['id']))
      elsif val.is_a?(Fixnum)
        instance_variable_set(var, klass.find_by_id(val))
      elsif val.is_a?(Array)
        return val if val[0].is_a?(klass)
        instance_variable_set(var, val.map { |attrs| klass.new(attrs) })
      end
      instance_variable_get(var)
    end
  
    def self.demodulized_name
      name.split('::').last.downcase
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

  end
end