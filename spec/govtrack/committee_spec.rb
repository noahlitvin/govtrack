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

    it "should be able to find an obsolete committee" do
      expect(GovTrack::Committee.find_by_obsolete(true).first.obsolete).to eql(true)
    end

    it "should be able to find a not obsolete committee" do
      c = GovTrack::Committee.find_by_obsolete(false).first
      expect(c.obsolete).to eql(false)
    end

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
