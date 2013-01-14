require "spec_helper"

describe "Point" do

  it "New point should give me a point turned off" do
    p = Point.new
    p.value.should eq :off
  end

  it "Turning a new point on should stay on" do
    p = Point.new
    p.value = :on
    p.value.should eq :on
  end
end