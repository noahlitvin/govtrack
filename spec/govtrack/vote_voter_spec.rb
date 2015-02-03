require 'helper'

describe GovTrack::VoteVoter do

  it "should find an array of VoteVoters based on parameters", :vcr do
      vote_voters = GovTrack::VoteVoter.find(vote:1, person: 400639)
      vote_voters.should be_an Array
      vote_voters[0].should be_a GovTrack::VoteVoter
  end

  it "should find an array of VoteVoters based on parameters with a dynamic finder", :vcr do
      vote_voters = GovTrack::VoteVoter.find_by_vote_and_person(1, 400639)
      vote_voters.should be_an Array
      vote_voters[0].should be_a GovTrack::VoteVoter
  end
  
  it "should find a vote voter with votes and people objects", :vcr do
    manny = GovTrack::Person.find_by_lastname("Cleaver").first
    vote = GovTrack::Vote.find_by_number_and_congress_and_chamber_and_session(183,112,'house',2012).first
    vote_voters = GovTrack::VoteVoter.find_by_person_and_vote(manny, vote)
    vote_voters.should be_an Array
    vote_voters[0].should be_a GovTrack::VoteVoter
  end

  it "should find a vote voter", :vcr do
    vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
    vote_voter.id.should eq 29825503
  end

  it "should retreive person as a Person and cache it", :vcr do
      vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
      vote_voter.person.should be_a GovTrack::Person
      
      WebMock.disable_net_connect!
      vote_voter.person.should be_a GovTrack::Person
      WebMock.allow_net_connect!
  end
  
  it "should retreive vote as a Vote and cache it", :vcr do
      vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
      vote_voter.vote.should be_a GovTrack::Vote
  
      WebMock.disable_net_connect!
      vote_voter.vote.should be_a GovTrack::Vote
      WebMock.allow_net_connect!
  end

  it "should retreive created as a DateTime object", :vcr do
      vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
      vote_voter.created.should be_a DateTime
  end

end