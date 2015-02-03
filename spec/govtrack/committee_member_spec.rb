require 'helper'

describe GovTrack::CommitteeMember do
    # need to use vcr for this -- because these frequently change
    # let(:foo) { VCR.use_cassette("foo") { create(:bar) } }
    let(:cm) { VCR.use_cassette('committee_member') { GovTrack::CommitteeMember.find_by_id(170284) } }
  
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
