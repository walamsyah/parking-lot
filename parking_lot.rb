require 'pry'
require './parking'

class ParkingLot
  attr_accessor :allocated_slot, :parking_number, :parking_lot, :run

  def initialize
    @allocated_slot = 0
    @parking_number = 0
    @parking_lot = []
    @run = false
  end

  def create_parking_lot_input(input)
    puts "\nOutput:"
    
    if input[1].nil?
      puts "Input should be a number\n\n"
    else
      @allocated_slot = input[1]
      puts "Created a parking lot with #{@allocated_slot} slots\n\n"
    end
  end

  def park_input(input)
    parking = Parking.new

    if @parking_lot.length < @allocated_slot.to_i
      if @parking_lot.count == 0
        parking.create_parking_lot(@parking_number + 1, input[1], input[2])
        @parking_lot.push(parking)
      else
        @parking_lot = @parking_lot.sort { |x, y| x.slot_no <=> y.slot_no }
        max = @parking_lot.max { |a, b| a.slot_no <=> b.slot_no}
        if @parking_lot.find { |x| x.slot_no == max.slot_no + 1 }.nil?
          if max.slot_no + 1 > @allocated_slot.to_i
            for i in 1..@parking_lot.length
              if @parking_lot.find { |x| x.slot_no == i }.nil?
                parking.create_parking_lot(i, input[1], input[2])
                @parking_lot.push(parking)
              end
            end
          else
            parking.create_parking_lot(max.slot_no + 1, input[1], input[2])
            @parking_lot.push(parking)
          end
        end
      end
    else
      puts "\nOutput:"
      puts "Sorry, parking lot is full\n\n"
    end
  end

  def status_input
    puts "\nOutput:"
    puts " slot_no  |    registration_no     |    colour "

    @parking_lot = @parking_lot.sort { |x, y| x.slot_no <=> y.slot_no }
    @parking_lot.each do |lot|
      puts "       #{lot.slot_no}      #{lot.registration_no}            #{lot.colour} "
    end

    puts "\n\n"
  end

  def leave_input(input)
    @parking_lot.delete_if {|lot| lot.slot_no.to_s == input[1].to_s }

    puts "\nOutput:"
    puts "Slot number #{input[1]} is free\n\n"
  end

  def registration_numbers_for_cars_with_colour_input(input)
    data = []

    @parking_lot.each do |lot|
      if lot.colour == input[1]
        data.push(lot.registration_no)
      end
    end

    output_data(data)
  end

  def slot_numbers_for_cars_with_colour_input(input)
    data = []
    
    @parking_lot.each do |lot|
      if lot.colour == input[1]
        data.push(lot.slot_no)
      end
    end
    
    output_data(data)
  end

  def slot_number_for_registration_number_input(input)
    data = []

    @parking_lot.each do |lot|
      if lot.registration_no == input[1]
        data.push(lot.slot_no)
      end
    end
   
    output_data(data)
  end

  def start
    argv = ARGV
    while(@run == false) do
      if argv.empty?
        puts "Input:"
        input = gets.split(" ")
      else
        cmd = gets
        break if cmd.nil?
        argv = 'ok'

        input = cmd.split(" ")
        puts "Input:"
        puts cmd
      end

      case input[0]
      when "create_parking_lot"
        create_parking_lot_input(input)
      when "park"
        park_input(input)
      when "leave"
        leave_input(input)
      when "status"
        status_input
      when "registration_numbers_for_cars_with_colour"
        registration_numbers_for_cars_with_colour_input(input)
      when "slot_numbers_for_cars_with_colour"
        slot_numbers_for_cars_with_colour_input(input)
      when "slot_number_for_registration_number"
        slot_number_for_registration_number_input(input)
      else
        puts "\nOutput:"
        puts "Wrong command\n\n"
      end
    end
  end

  private

  def output_data(data)
    puts "\nOutput:"
    
    if data.empty?
      puts "not found"
    else
      puts data.join(', ')
    end
    
    puts "\n"
  end
end
