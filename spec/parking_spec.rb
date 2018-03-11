require 'pry'
require_relative '../parking'

describe Parking do
  describe "set_colour" do
    it "will set value to color" do
      parking = Parking.new
      parking.set_colour('White')
      expect(parking.colour).to eq 'White'
    end
  end

  describe "set_slot_no" do
    it "will set value to slot_no" do
      parking = Parking.new
      parking.set_slot_no(5)
      expect(parking.slot_no).to eq 5
    end
  end

  describe "set_registration_no" do
    it "will set value to registration_no" do
      parking = Parking.new
      parking.set_registration_no('B-1234-OK')
      expect(parking.registration_no).to eq 'B-1234-OK'
    end
  end

  describe "create_parking_lot" do
    it "will create object value" do
      parking = Parking.new
      
      expect(parking.slot_no).to eq nil
      expect(parking.registration_no).to eq nil
      expect(parking.colour).to eq nil

      parking.create_parking_lot(1, 'B-1234-OK', 'White')

      expect(parking.slot_no).to eq 1
      expect(parking.registration_no).to eq 'B-1234-OK'
      expect(parking.colour).to eq 'White'
    end
  end
end
