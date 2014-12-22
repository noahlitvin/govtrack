require 'helper'

describe GovTrack::Person do

  it "should find an array of people based on parameters" do
    people = GovTrack::Person.find(lastname:"Paul", gender: "male")
    people.should be_an Array
    people[0].should be_a GovTrack::Person
  end

  it "should find an array of people based on parameters with a dynamic finder" do
    people = GovTrack::Person.find_by_lastname_and_gender("Paul", "male")
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
    person = GovTrack::Person.find_by_uri('/api/v2/person/300038/')
    person.id.should eq 300038
  end

  it "should retreive roles as a Role array and cache it" do
    person = GovTrack::Person.find_by_id(400326)
    person.roles.should be_an Array
    person.roles[0].should be_a GovTrack::Role
    
    WebMock.disable_net_connect!
    person.roles.should be_an Array
    person.roles[0].should be_a GovTrack::Role
    WebMock.allow_net_connect!
  end

  it "should retreive birthday as a Date object" do
    person = GovTrack::Person.find_by_id(400326)
    person.birthday.should be_a Date
  end
  
end
