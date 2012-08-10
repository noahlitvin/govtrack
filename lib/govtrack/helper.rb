class Object
  def to_bill_type_number
    #Fix for API not accepting bill_type as a string
    case self.to_s
    when 'house_resolution'
      1
    when 'senate_bill'
      2
    when 'house_bill'
      3
    when 'senate_resolution'
      4
    when 'house_concurrent_resolution'
      5
    when 'senate_concurrent_resolution'
      6
    when 'house_joint_resolution'
      7
    when 'senate_joint_resolution'
      8
    else
      self
    end
  end

  def to_current_status_number
    #Fix for API not accepting current_status as a string
    case self.to_s
    when 'introduced'
      1
    when 'referred'
      2
    when 'reported'
      3
    when 'pass_over_house'
      4
    when 'pass_over_senate'
      5
    when 'passed_simpleres'
      6
    else
      self
    end
  end

  def to_display_text
    case self
    when "+"
      "Aye"
    when "-"
      "No"
    when "0"
      "Not Voting"
    when "P"
      "Present"
    else
      self
    end
  end
end