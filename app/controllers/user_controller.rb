class UserController < WebsocketRails::BaseController
  def new_user
    #User.create({name: 'Guest', client_id: client_id})
    User.create({name: 'Guest'})
    puts client_id
  end

  def hold_seat
    seat = Seat.find_by_number(message[:id].to_i)
    seat_state = seat.status == 'open' ? 'hold' : 'open' 
    seat.update_attribute(:status, seat_state)
    broadcast_message :update_seat_status, {number: seat.number, state: seat_state}
  end
end
