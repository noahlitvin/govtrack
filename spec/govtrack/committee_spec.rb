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
end
