class BookingController < ApplicationController

  def index
    @seat = Seat.all
  end

  def create
    user = User.create({name: params[:book][:name] || 'xyz'})
    params[:book][:seat_number].split(',').each do |number|
      seat = Seat.find(number)
      seat.update_attributes({user_id: user.id, status: 'booked'})
    end
  end
end
