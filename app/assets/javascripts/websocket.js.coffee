window.Booking = {}

class Booking.User

  constructor: (@user_name,@full_name) ->

  serialize: =>
    {
      user_name: @user_name
      full_name: @full_name
    }

class Booking.Controller

  constructor: (url,useWebSockets) ->
    @dispatcher = new WebSocketRails(url,useWebSockets)
    @dispatcher.on_open = @createGuestUser

  createGuestUser: =>
    @user = new Booking.User('Guest','Guest User')
    @dispatcher.trigger 'new_user', @user.serialize()
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'update_seat_status', @updateSeatStatus
    @dispatcher.bind 'unhold_seat', @unholdSeat
    $('.open').click @holdSeat
    $("#user_list").on "click", ".close", @releaseSeat


  holdSeat: (event) =>
    seat_id = event.target.id
    @dispatcher.trigger 'hold_seat', {id: seat_id}

  releaseSeat: (event) =>
    seat_id = event.target.id
    @dispatcher.trigger 'release_seat', {id: seat_id}
  
  updateSeatStatus: (message) =>
    seat_number = message['number']
    $seat = $('#' + seat_number)
    $seat.removeClass('open hold').addClass(message['state']) 
    $seat.unbind('click');
    button = '<span class="badge white"><button class="close" id=button_'+seat_number+'>&times;</button></span>'
    li = '<li class="label" id=li_' + seat_number + '>Seat number ' + seat_number + ' on hold' + button + '</li><br>'
    $('#user_list').append(li)


  unholdSeat: (message) =>
    seat_number = message['number']
    $seat = $('#' + seat_number)
    $seat.removeClass('open hold').addClass(message['state']) 
    $('#li_' + seat_number).remove();
