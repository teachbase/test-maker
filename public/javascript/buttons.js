function sendData() {
  $( document ).ready(function() {
    $( "#quiz-form" ).submit(function(event) {
      data = $( "#quiz-form" ).serialize();
      $.ajax({
        type: "POST",
        url: "/",
        data: data,
        dataType: "html"
      }).done( function (response) {
        $( "#results" ).html(response)
      })
      event.preventDefault();
    });
  });
}

function dropdownSelection(input, button, regexp, text) {
  $( document ).ready(function() {
    $( button ).click(function(event) {
      $( input ).val(regexp)
      $( button ).text(text)
    });
  });
}
