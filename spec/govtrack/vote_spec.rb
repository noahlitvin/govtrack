require 'helper'

describe GovTrack::Vote do

  it "should find an array of votes based on parameters" do
    votes = GovTrack::Vote.find(id: 113728)
    votes.should be_an Array
    votes[0].should be_a GovTrack::Vote
  end

  it "should find an array of votes based on parameters with a dynamic finder" do
    votes = GovTrack::Vote.find_by_number_and_congress_and_chamber_and_session(183,112,'house',2012)
    votes.should be_an Array
    votes[0].should be_a GovTrack::Vote
  end

  it "should find a vote" do
    vote = GovTrack::Vote.find_by_id(1)
    vote.id.should eq 1
  end

  it "should retreive related_bill as a Bill and cache it" do
    vote = GovTrack::Vote.find_by_id(34577)
    vote.related_bill.should be_a GovTrack::Bill
    
    FakeWeb.allow_net_connect = false
    vote.related_bill.should be_a GovTrack::Bill
    FakeWeb.allow_net_connect = true
  end

  it "should retreive created as a DateTime object" do
    vote = GovTrack::Vote.find_by_id(34577)
    vote.created.should be_a DateTime
  end

  it "should be able to find a vote on a specific bill" do
    bill = GovTrack::Bill.find_by_id(75622)
    # now we need to find any votes (rolls) on this specific bill
    #related_vote = GovTrack::Vote.find(related_bill: bill.id)
    vote = GovTrack::Vote.find(related_bill: bill.id).first
    vote.related_bill.should eq(bill)
  end

end