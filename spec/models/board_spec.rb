require "spec_helper"

describe "Board" do

  it "Should create an empty board in a variety of ways" do
    b = Board.new
    b.rows.should eq 0
    b.columns.should eq 0
    b2 = Board.new(0)
    b2.rows.should eq 0
    b2.columns.should eq 0
    b3 = Board.new(0,0)
    b3.rows.should eq 0
    b3.columns.should eq 0
  end

  it "should create a 1x1 board and manage state" do
    b = Board.new(1,1)
    b.rows.should eq 1
    b.columns.should eq 1
    b.cell_value(1,1).should eq :off
    b.set_cell_value(1,1,:off)
    b.cell_value(1,1).should eq :off
    b.set_cell_value(1,1,:on)
    b.cell_value(1,1).should eq :on
  end

  it "should count current neighbors correctly" do
    b = Board.new(10,10)
    b.rows.should eq 10
    b.columns.should eq 10
    b.cell_value(5,5).should equal :off
    b.neighbor_count(5,5).should eq 0
    b.set_cell_value(4,4,:on)
    b.neighbor_count(5,5).should eq 1
    b.set_cell_value(6,6,:on)
    b.neighbor_count(5,5).should eq 2
    b.set_cell_value(5,4,:on)
    b.neighbor_count(5,5).should eq 3
    b.set_cell_value(5,6,:on)
    b.neighbor_count(5,5).should eq 4
    b.set_cell_value(4,6,:on)
    b.neighbor_count(5,5).should eq 5
  end

  it "should handle simple next generations"do
    b = Board.new(10,10)
    b.next_generation
    b.cell_value(5,5).should eq :off

    b.set_cell_value(5,5,:on)
    b.next_generation
    b.next_cell_value(5,5).should eq :off
  end

  it "should handle a blinker" do
  #Blinker
  #  puts "Blank"
    b = Board.new(10,10)
    b.next_generation
    b.next_generation
    b.neighbor_count(4,5).should eq 0
    #puts "First Blinker"
    b.set_cell_value(5,5,:on)
    b.set_cell_value(4,5,:on)
    b.set_cell_value(6,5,:on)
    b.neighbor_count(5,5).should eq 2
    b.next_generation
    #puts "Second Generation Blinker"
    b.neighbor_count(5,5).should eq 2
    b.cell_value(5,5).should eq :on
    b.cell_value(4,5).should eq :off
    b.cell_value(6,5).should eq :off
    b.cell_value(5,4).should eq :on
    b.cell_value(5,6).should eq :on
    b.next_generation
    b.neighbor_count(5,5).should eq 2
    b.cell_value(5,5).should eq :on
    b.cell_value(4,5).should eq :on
    b.cell_value(6,5).should eq :on
    b.cell_value(5,4).should eq :off
    b.cell_value(5,6).should eq :off
    b.next_generation(true)
    b.neighbor_count(5,5).should eq 2
    b.cell_value(5,5).should eq :on
    b.cell_value(4,5).should eq :off
    b.cell_value(6,5).should eq :off
    b.cell_value(5,4).should eq :on
    b.cell_value(5,6).should eq :on

  end
end
