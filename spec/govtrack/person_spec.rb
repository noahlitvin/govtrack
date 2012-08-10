require 'helper'

describe GovTrack::Person do

  it "should find an array of people based on parameters" do
    people = GovTrack::Person.find(roles__party:"Republican", roles__current: "true")
    people.should be_an Array
    people[0].should be_a GovTrack::Person
  end

  it "should find an array of people based on parameters with a dynamic finder" do
    people = GovTrack::Person.find_by_roles__party_and_roles__current("Republican", "true")
    people.should be_an Array
    people[0].should be_a GovTrack::Person
  end
  
  it "should find a person by id" do
    person = GovTrack::Person.find_by_id(400326)
    person.id.should eq "400326"
    person.firstname.should eq "David"
    person.lastname.should eq "Price"
  end

  it "should find a person by uri" do
    person = GovTrack::Person.find_by_uri('/api/v1/person/300038/')
    person.id.should eq "300038"
  end

  it "should retreive current_role as a Role and cache it" do
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
  
end
