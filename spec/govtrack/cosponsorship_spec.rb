require 'helper'

describe GovTrack::Cosponsorship do

  let(:list) { GovTrack::Cosponsorship.find(bill: 74370, person: 400076) }
  let(:co) { list.first }

  describe "#find" do
    it "returns a list of Cosponsorships" do
      list.first.class.should eq GovTrack::Cosponsorship
    end
  end

  describe "#person" do
    it "returns the cosponsor" do
      co.person.class.should eq GovTrack::Person
    end
  end

  describe "#bill" do
    it "returns the bill being cosponsored" do
      co.bill.class.should eq GovTrack::Bill
    end
  end

  describe "#role" do
    it "returns the role of the cosponsor" do
      co.role.class.should eq GovTrack::Role
    end
  end
end
