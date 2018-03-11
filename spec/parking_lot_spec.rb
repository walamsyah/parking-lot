require_relative '../parking_lot'

describe ParkingLot do
  describe "initialize" do
    it "returns new parking lot instance" do
      parking_lot = ParkingLot.new
      
      expect(parking_lot.allocated_slot).to eq 0
      expect(parking_lot.parking_number).to eq 0
      expect(parking_lot.parking_lot).to eq []
      expect(parking_lot.run).to eq false
    end
  end

  describe "create_parking_lot_input" do
    it "will set @allocated_slot value" do
      parking = ParkingLot.new
      parking.create_parking_lot_input(['cmd', 3])
      
      expect(parking.allocated_slot).to eq 3
    end
  end

  describe "park_input" do
    it "will set @parking_lot value" do
      parking = ParkingLot.new
      parking.allocated_slot = 3
      parking.park_input(['cmd', 'B-1234-OK', 'White'])

      expect(parking.parking_lot.first.slot_no).to eq 1
      expect(parking.parking_lot.first.registration_no).to eq 'B-1234-OK'
      expect(parking.parking_lot.first.colour).to eq 'White'
    end
  end

  describe "status_input" do
    it "will show status parking lot" do
      parking = ParkingLot.new
      parking.allocated_slot = 3
      parking.park_input(['cmd', 'B-1234-OK', 'White'])

      expect do
        parking.status_input
      end.to output("\nOutput:\n slot_no  |    registration_no     |    colour \n       1      B-1234-OK            White \n\n\n").to_stdout
    end
  end

  describe "leave_input" do
    it "will remove values from @parking_lot" do
      parking = ParkingLot.new
      parking.allocated_slot = 3
      parking.park_input(['cmd', 'B-1234-OK', 'White'])

      expect(parking.parking_lot.size).to eq 1

      parking.leave_input(['cmd', '1'])

      expect(parking.parking_lot.size).to eq 0
    end
  end

  describe "registration_numbers_for_cars_with_colour_input" do
    it "will show registration number by color input" do
      parking = ParkingLot.new
      parking.allocated_slot = 3
      parking.park_input(['cmd', 'B-1234-OK', 'White'])

      expect do
        parking.registration_numbers_for_cars_with_colour_input(['cmd', 'White'])
      end.to output("\nOutput:\nB-1234-OK\n\n").to_stdout
    end
  end

  describe "slot_numbers_for_cars_with_colour_input" do
    it "will show parking slot number by color input" do
      parking = ParkingLot.new
      parking.allocated_slot = 3
      parking.park_input(['cmd', 'B-1234-OK', 'White'])

      expect do
        parking.slot_numbers_for_cars_with_colour_input(['cmd', 'White'])
      end.to output("\nOutput:\n1\n\n").to_stdout
    end
  end

  describe "slot_number_for_registration_number_input" do
    it "will show parking slot number by registration number input" do
      parking = ParkingLot.new
      parking.allocated_slot = 3
      parking.park_input(['cmd', 'B-1234-OK', 'White'])

      expect do
        parking.slot_number_for_registration_number_input(['cmd', 'B-1234-OK'])
      end.to output("\nOutput:\n1\n\n").to_stdout
    end
  end
end
