require 'helper'

describe GovTrack::Person do

  it "should find an array of roles based on parameters" do
    # this is the wrong way to find current republicans -- this should be by role
    #people = GovTrack::Person.find(roles__party:"Republican", roles__current: "true")
    people = GovTrack::Person.find(gender:"male", lastname: "smith")
    people.should be_an Array
    people[0].should be_a GovTrack::Person
  end

  it "should find an array of people based on parameters with a dynamic finder" do
    people = GovTrack::Person.find_by_gender_and_lastname("male", "smith")
    people.should be_an Array
    people[0].should be_a GovTrack::Person
  end
  
  it "should find a person by id" do
    person = GovTrack::Person.find_by_id(400326)
    person.id.should eq 400326
    person.firstname.should eq "David"
    person.lastname.should eq "Price"
  end

  it "should find a person by uri" do
    person = GovTrack::Person.find_by_uri('/api/v1/person/300038/')
    person.id.should eq "300038"
  end

  it "should retrieve current_role as a Role and cache it" do
    # going to add some definition to current_role: it is the role someone has in the current congress
    person = GovTrack::Person.find_by_id(400326)
    person.current_role.should be_a GovTrack::Role
    
    FakeWeb.allow_net_connect = false
    person.current_role.should be_a GovTrack::Role
    FakeWeb.allow_net_connect = true
  end

  it "should retreive roles as a Role array and cache it" do
    person = GovTrack::Person.find_by_id(400326)
    person.roles.should be_an Array
    person.roles[0].should be_a GovTrack::Role
    
    FakeWeb.allow_net_connect = false
    person.roles.should be_an Array
    person.roles[0].should be_a GovTrack::Role
    FakeWeb.allow_net_connect = true
  end

  it "should retreive birthday as a Date object" do
    person = GovTrack::Person.find_by_id(400326)
    person.birthday.should be_a Date
  end

  it "should be able to get current roles from all people" do
    GovTrack::Person.find(limit: 10).each do |person|
      puts "roll: |#{person.current_role}|"
      lambda { person.current_role }.should_not raise_error
    end
  end

  # person roles testing
  it "non-current rep should return nil for current role" do
    # "Rep.  Watts [R-OK4, 1995-2002]"
    GovTrack::Person.find_by_id(400541).current_role.should be_nil
  end

  it "past president should return nil" do
    # President Calvin Coolidge [R, 1923-1929]
    GovTrack::Person.find_by_id(402859).current_role.should be_nil
  end

  it "current president should return " do
    # 400629   <-- not correct . . .
    # "President Barack Obama [D]"
    GovTrack::Person.find_by_id(400629).current_role.description.should eql('President')
  end

  it "past senator should return nil" do
    # 300157
    # Thurmond, Strom (Sen.) [R-SC, 1961-2002]
    GovTrack::Person.find_by_id(300157).current_role.should be_nil
  end

  it "current senator should return senator" do
    # Portman, Robert “Rob” (Sen.) [R-OH],
    # 400325
    GovTrack::Person.find_by_id(400325).current_role.description.should eql('Senator from Ohio')
  end

  it "should be able to find a person from name and district" do
    pending "until we get time to implement"
  end

  
end
