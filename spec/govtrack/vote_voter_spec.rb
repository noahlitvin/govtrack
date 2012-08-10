require 'helper'

describe GovTrack::VoteVoter do

  it "should find an array of VoteVoters based on parameters" do
    vote_voters = GovTrack::VoteVoter.find(vote:1, person: 400639)
    vote_voters.should be_an Array
    vote_voters[0].should be_a GovTrack::VoteVoter
  end

  it "should find an array of VoteVoters based on parameters with a dynamic finder" do
    vote_voters = GovTrack::VoteVoter.find_by_vote_and_person(1, 400639)
    vote_voters.should be_an Array
    vote_voters[0].should be_a GovTrack::VoteVoter
  end
  
  it "should find a vote voter with votes and people objects" do
    manny = GovTrack::Person.find_by_firstname_and_lastname("Emanuel","Cleaver").first
    vote = GovTrack::Vote.find_by_number_and_congress(183,112).first
    vote_voters = GovTrack::VoteVoter.find_by_person_and_vote(manny, vote)
    vote_voters.should be_an Array
    vote_voters[0].should be_a GovTrack::VoteVoter
  end

  it "should find a vote voter" do
    vote_voter = GovTrack::VoteVoter.find_by_id(8248471)
    vote_voter.id.should eq "8248471"
  end

  it "should retreive person as a Person and cache it" do
    vote_voter = GovTrack::VoteVoter.find_by_id(8248471)
    vote_voter.person.should be_a GovTrack::Person
    
    FakeWeb.allow_net_connect = false
    vote_voter.person.should be_a GovTrack::Person
    FakeWeb.allow_net_connect = true
  end
  
  it "should retreive vote as a Vote and cache it" do
    vote_voter = GovTrack::VoteVoter.find_by_id(8248471)
    vote_voter.vote.should be_a GovTrack::Vote

    FakeWeb.allow_net_connect = false
    vote_voter.vote.should be_a GovTrack::Vote
    FakeWeb.allow_net_connect = true
  end

  it "should retreive created as a DateTime object" do
    vote_voter = GovTrack::VoteVoter.find_by_id(8248471)
    vote_voter.created.should be_a DateTime
  end

end