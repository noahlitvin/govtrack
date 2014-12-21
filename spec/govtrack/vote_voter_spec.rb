require 'helper'

describe GovTrack::VoteVoter do

  it "should find an array of VoteVoters based on parameters" do
    VCR.use_cassette('vote_voter_find') do
      vote_voters = GovTrack::VoteVoter.find(vote:1, person: 400639)
      vote_voters.should be_an Array
      vote_voters[0].should be_a GovTrack::VoteVoter
    end
  end

  it "should find an array of VoteVoters based on parameters with a dynamic finder" do
    vote_voters = GovTrack::VoteVoter.find_by_vote_and_person(1, 400639)
    vote_voters.should be_an Array
    vote_voters[0].should be_a GovTrack::VoteVoter
  end
  
  it "should find a vote voter with votes and people objects" do
    manny = GovTrack::Person.find_by_lastname("Cleaver").first
    vote = GovTrack::Vote.find_by_number_and_congress_and_chamber_and_session(183,112,'house',2012).first
    vote_voters = GovTrack::VoteVoter.find_by_person_and_vote(manny, vote)
    vote_voters.should be_an Array
    vote_voters[0].should be_a GovTrack::VoteVoter
  end

  it "should find a vote voter" do
    vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
    vote_voter.id.should eq 29825503
  end

  it "should retreive person as a Person and cache it" do
    vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
    vote_voter.person.should be_a GovTrack::Person
    
    FakeWeb.allow_net_connect = false
    vote_voter.person.should be_a GovTrack::Person
    FakeWeb.allow_net_connect = true
  end
  
  it "should retreive vote as a Vote and cache it" do
    vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
    vote_voter.vote.should be_a GovTrack::Vote

    FakeWeb.allow_net_connect = false
    vote_voter.vote.should be_a GovTrack::Vote
    FakeWeb.allow_net_connect = true
  end

  it "should retreive created as a DateTime object" do
    vote_voter = GovTrack::VoteVoter.find_by_id(29825503)
    vote_voter.created.should be_a DateTime
  end

  # it "should be able to provide a description of the vote" do
  # doesn't look like this is available
  #   VCR.use_cassette('vote_voter_find_by_id') do
  #     vv = GovTrack::VoteVoter.find_by_id(29690500)
  #     vv.vote_description.should eql("McIntyre, Mike (Rep.) [D-NC7] voted Yea on H.R. 527: Responsible Helium Administration and Stewardship Act")
  #   end
  # end
  it "should test webmock" do
    VCR.use_cassette('synopsis') do
      response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
    end
  end

end