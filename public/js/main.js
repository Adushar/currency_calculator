$("#converter input[type='submit']").click(function() {
  amount = $("#converter input[name=amount]").val()
  to = $("#converter select[name=to] option:selected").val()
  from = $("#converter select[name=from] option:selected").val()

  event.preventDefault();

  $.get( "/convert",
    { from: from, to: to, amount: amount },
    function( data ) {
      $( "#result" ).val( data["amount"] );
  });
});

$("#converter #change_currencies").click(function() {
  to = $("#converter select[name=to] option:selected").val()
  from = $("#converter select[name=from] option:selected").val()

  event.preventDefault();

  $("#converter select[name=to]").val(from)
  $("#converter select[name=from]").val(to)
});
