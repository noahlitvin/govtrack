require 'helper'

describe GovTrack::Role do

  it "should find an array of roles based on parameters" do
    roles = GovTrack::Role.find(state:"MD", current: true)
    roles.should be_an Array
    roles[0].should be_a GovTrack::Role
  end

  it "should find an array of roles based on parameters with a dynamic finder" do
    roles = GovTrack::Role.find_by_state_and_current("MD", true)
    roles.should be_an Array
    roles[0].should be_a GovTrack::Role
  end
  
  it "should find a role by id" do
    role = GovTrack::Role.find_by_id(387)
    role.id.should eq "387"
  end
  
  it "should retreive startdate as a Date object" do
    role = GovTrack::Role.find_by_id(387)
    role.startdate.should be_a Date
  end
  
  it "should retreive enddate as a Date object" do
    role = GovTrack::Role.find_by_id(387)
    role.enddate.should be_a Date
  end
  
end
