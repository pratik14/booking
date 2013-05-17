jQuery ->
  $('.open').click ->
    url =  '/booking/' + this.id + '/hold'
    $.get(url)
  
  $('#checkout').click (e) ->
    selected = $('.hold')
    if selected.length > 0
      seat_no = $.map selected, (seat) ->
                  seat.id
      $('#book_seat_number').val(seat_no)
    else
      alert('Please select seat to continue!!')
      false

  $('#book').click ->
    $('#book').hide();
    $('#spinner').show();
    true
