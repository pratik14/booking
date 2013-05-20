class UserController < WebsocketRails::BaseController
  def new_user
    #User.create({name: 'Guest', client_id: client_id})
    User.create({name: 'Guest'})
    puts client_id
  end

  def hold_seat
    seat = Seat.find_by_number(message[:id].to_i)
    seat.update_attribute(:status, 'hold')
    broadcast_message :update_seat_status, {number: seat.number, state: 'hold'}
  end

  def release_seat
    seat = Seat.find_by_number(message[:id].split('_')[1].to_i)
    puts '##################'
    puts seat
    seat.update_attribute(:status, 'open')
    broadcast_message :unhold_seat, {number: seat.number, state: 'open'}
  end
end
