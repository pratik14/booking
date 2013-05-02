jQuery ->
  dispatcher = new WebSocketRails("localhost:3000/websocket")

  channel = dispatcher.subscribe("seat_state")

  channel.bind "change_seat_color", (data) ->
    $('#' + data[0]).removeClass('open hold').addClass('booked') 
    $('#user_list').append('<li>'+data[1]+ ' booked seat no.'+ data[0]+'</li>')
    $('#flash').html('<div class="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + 'Seat no ' + data[0] + ' is Booked. Hurry Up!!</div>')


