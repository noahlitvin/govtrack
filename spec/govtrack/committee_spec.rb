require 'helper'

describe GovTrack::Committee do

  let(:comm) { GovTrack::Committee.find_by_id(2650) }

  describe '#find_by_id' do
    it 'returns the committee' do
      comm.class.should eq GovTrack::Committee
    end
  end

  describe '#subcommittee?' do
    it 'returns true if committee has a parent committee' do
      comm.subcommittee?.should eq false
    end
  end

  describe '#committee' do
    context 'when committee is a subcommittee' do

      before { comm.stub(:committee) { GovTrack::Committee.new } }

      it 'returns the parent committee' do
        comm.committee.class.should eq GovTrack::Committee
      end
    end

    context 'when committee is not a subcommittee' do
      it 'returns nil' do
        comm.committee.should eq nil
      end
    end
  end
end
