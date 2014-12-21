require 'helper'

describe GovTrack::CommitteeMember do
  
  let(:cm) { GovTrack::CommitteeMember.find_by_id(128287) }

  describe '#find_by_id' do
    it 'returns relationship between a person and committee' do
      cm.class.should eq GovTrack::CommitteeMember
    end
  end

  describe '#committee' do
    it 'returns the committee being served on' do
      cm.committee.class.should eq GovTrack::Committee
    end
  end

  describe '#person' do
    it 'returns the person serving on a committee' do
      cm.person.class.should eq GovTrack::Person
    end
  end
end
