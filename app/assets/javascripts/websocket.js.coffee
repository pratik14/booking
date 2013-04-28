jQuery ->
  dispatcher = new WebSocketRails("localhost:3000/websocket")

  channel = dispatcher.subscribe("seat_state")

  channel.bind "change_seat_color", (data) ->
    $('#' + data).removeClass('open hold').addClass('booked') 
