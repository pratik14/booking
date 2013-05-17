jQuery ->
  dispatcher = new WebSocketRails(request_url)

  channel = dispatcher.subscribe("seat_state")

  channel.bind "change_seat_color", (data) ->
    $user_list = $('#user_list')
    new_option = ('<li class= "label label-success">'+data[1]+ ' booked seat no.'+ data[0]+'</li>')
    
    $('#' + data[0]).removeClass('open hold').addClass('booked') 
    
    $user_list.prepend(new_option)
    
    $('#flash').html('<div class="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + 'Seat no ' + data[0] + ' is Booked. Hurry Up!!</div>')

  
  channel.bind "hold_seat", (data) ->
    $('#' + data[0]).removeClass('open hold').addClass(data[1]) 



