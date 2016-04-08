function sendData() {
  $( document ).ready(function() {
    $( "#quiz-form" ).submit(function(event) {
      $( "#submit-btn" ).button("loading")
      $( "#download-link" ).addClass("disabled")
      data = $( "#quiz-form" ).serialize();
      $.ajax({
        type: "POST",
        url: "/",
        data: data,
        dataType: "html"
      }).done( function(response) {
        $( "#results" ).html(response);
        $( "#submit-btn" ).button("reset")
        $( "#download-link" ).button("reset")
      })
      event.preventDefault();
    });
  });
}

function tooltips() {
  $(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
  });
}
