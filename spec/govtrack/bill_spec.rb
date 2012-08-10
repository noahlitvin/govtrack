require 'helper'

describe GovTrack::Bill do

  it "should find an array of bills based on parameters" do
    bills = GovTrack::Bill.find(congress:112, is_current: "true")
    bills.should be_an Array
    bills[0].should be_a GovTrack::Bill
  end

  it "should iterate through an array of bills based on parameters when supplied with a block" do
    count = 0
    GovTrack::Bill.find(congress:95, bill_type: 'house_concurrent_resolution', limit: 70) { |bill| count += 1 }
    count.should eq GovTrack::Bill.find(congress:95, bill_type: 'house_concurrent_resolution').total
  end

  it "should find an array of bills based on parameters with a dynamic finder" do
    bills = GovTrack::Bill.find_by_congress_and_is_current(112, "true")
    bills.should be_an Array
    bills[0].should be_a GovTrack::Bill
  end

  it "should find a bill by id" do
    bill = GovTrack::Bill.find_by_id(74369)
    bill.id.should eq "74369"
  end

  it "should retreive sponsor as a Person and cache it" do
    bill = GovTrack::Bill.find_by_id(74369)
    bill.sponsor.should be_a GovTrack::Person
    
    FakeWeb.allow_net_connect = false
    bill.sponsor.should be_a GovTrack::Person
    FakeWeb.allow_net_connect = true
  end

  it "should retreive cosponsors as a Person array and cache it" do
    bill = GovTrack::Bill.find_by_id(2343)
    bill.cosponsors.should be_an Array
    bill.cosponsors[0].should be_a GovTrack::Person
    
    FakeWeb.allow_net_connect = false
    bill.cosponsors.should be_an Array
    bill.cosponsors[0].should be_a GovTrack::Person
    FakeWeb.allow_net_connect = true
  end

  it "should return an empty array if there are no cosponsors" do
    bill = GovTrack::Bill.find_by_id(74369)
    bill.cosponsors.should be_empty
  end

  it "should retreive introduced_date as a Date object" do
    bill = GovTrack::Bill.find_by_id(2343)
    bill.introduced_date.should be_a Date
  end
  
  it "should retreive current_status_date as a Date object" do
    bill = GovTrack::Bill.find_by_id(2343)
    bill.current_status_date.should be_a Date
  end
    
end