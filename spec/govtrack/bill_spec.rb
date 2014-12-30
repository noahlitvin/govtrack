require 'helper'

describe GovTrack::Bill do

  it "should find an array of bills based on parameters", :vcr do
    bills = GovTrack::Bill.find(congress:112, current_status: 'passed_bill')
    bills.should be_an Array
    bills[0].should be_a GovTrack::Bill
  end

  it "should iterate through an array of bills based on parameters when supplied with a block", :vcr do
    count = 0
    GovTrack::Bill.find(congress:95, current_status: 'passed_bill', limit: 70) { |bill| count += 1 }
    count.should eq GovTrack::Bill.find(congress:95, current_status: 'passed_bill').total
  end

  it "should find an array of bills based on parameters with a dynamic finder", :vcr do
    bills = GovTrack::Bill.find_by_congress_and_current_status(112, "passed_bill")
    bills.should be_an Array
    bills[0].should be_a GovTrack::Bill
  end

  it "should find a bill by id", :vcr do
    bill = GovTrack::Bill.find_by_id(74369)
    bill.id.should eq 74369
  end

  it "should return an empty array if there are no cosponsors", :vcr do
    bill = GovTrack::Bill.find_by_id(74369)
    bill.cosponsors.should be_empty
  end

  it "should be able to find a list of votes for a bill", :vcr do
    vote =  GovTrack::Vote.find_by_id(1)
    GovTrack::Vote.find(related_bill: vote.related_bill.id).map(&:id).should include(vote.id)
  end
  
  context 'when i have a bill', :vcr do
    let(:bill){ GovTrack::Bill.find_by_id(2343) }
    
    it "should retreive cosponsors as a Person array and cache it" do
      bill.cosponsors.should be_an Array
      bill.cosponsors[0].should be_a GovTrack::Person
      
      WebMock.disable_net_connect!
      bill.cosponsors.should be_an Array
      bill.cosponsors[0].should be_a GovTrack::Person
      WebMock.allow_net_connect!
    end
    
    it "should retreive introduced_date as a Date object" do
      bill.introduced_date.should be_a Date
    end    
    
    it "should retreive current_status_date as a Date object" do
      bill.current_status_date.should be_a Date
    end    
    
    it "should retreive sponsor as a Person and cache it" do
      bill.sponsor.should be_a GovTrack::Person
      
      WebMock.disable_net_connect!
      bill.sponsor.should be_a GovTrack::Person
      WebMock.allow_net_connect!
    end
    
    it "should have a committee of type GovTrack::Committee" do
      expect(bill.committees.first).to be_a GovTrack::Committee
    end
    
    it "should be a Senate Committee on the Judiciary" do
      expect(bill.committees.first.name).to eql("Senate Committee on the Judiciary")
    end
    
  end

  it "should have a committee associated with the bill" do
    bill = GovTrack::Bill.find_by_id(2343)
    expect(bill.committees.first.class).to eq GovTrack::Committee
    expect(bill.committees.first.name).to eq "Senate Committee on the Judiciary"
  end
  
end