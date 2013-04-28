jQuery ->
  $('.open').click ->
    $(this).toggleClass('hold')
  
  $('#checkout').click ->
    seat_no = $.map $(".hold"), (seat) ->
            seat.id
    $('#book_seat_number').val(seat_no)
  
  $('#book').click ->
    $('#book').hide();
    $('#spinner').show();
    true
  
