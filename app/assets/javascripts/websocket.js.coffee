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
    channel = @dispatcher.subscribe("confirm_seat")
    channel.bind "change_seat_color", (seat_number) ->
      $seat = $('#' + seat_number)
      $seat.removeClass('open hold').addClass('booked') 
      $('#li_' + seat_number).remove();
      li = '<li class="label label-success">Seat number ' + seat_number + ' is Booked</li>'
      $('#user_list').prepend(li)
    $('.open').click @holdSeat
    $("#user_list").on "click", ".close", @releaseSeat

  holdSeat: (event) =>
    seat_number = event.target.id
    button = '<span class="badge white"><button class="close" id=button_'+seat_number+'>&times;</button></span>'
    li = '<li class="label" id=li_' + seat_number + '>Seat number ' + seat_number + ' on hold' + button + '</li>'
    $('#user_list').prepend(li)
    @dispatcher.trigger 'hold_seat', {id: seat_number}

  releaseSeat: (event) =>
    seat_id = event.target.id
    @dispatcher.trigger 'release_seat', {id: seat_id}
  
  updateSeatStatus: (message) =>
    seat_number = message['number']
    $seat = $('#' + seat_number)
    $seat.removeClass('open hold').addClass(message['state']) 
    $seat.unbind('click');


  unholdSeat: (message) =>
    seat_number = message['number']
    $seat = $('#' + seat_number)
    $seat.removeClass('open hold').addClass(message['state']) 
    $('#li_' + seat_number).remove();
    $seat.click(@holdSeat);
