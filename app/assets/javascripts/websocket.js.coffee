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
    $('.open').click @holdSeat

  holdSeat: (event) =>
    event.preventDefault()
    seat_id = event.target.id
    @dispatcher.trigger 'hold_seat', {id: seat_id}
  
  updateSeatStatus: (message) =>
    $('#' + message['number']).removeClass('open hold').addClass(message['state']) 

