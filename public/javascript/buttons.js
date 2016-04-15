$( document ).ready( function() {
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
    }).error( function() {
      $( "#results" ).html(
        "<div class='text-danger bg-danger text-center'>Что-то пошло не так. Проверьте подключение к Интернету и правильность введенных данных</div>"
      );
      $( "#submit-btn" ).button("reset");
    });
    console.log(data);
    event.preventDefault();
  });
});

$( document ).ready( function(){
  $('[data-toggle="tooltip"]').tooltip();   
});

window.onbeforeunload = function() {
  $.ajax({
    type: "DELETE",
    url: "/"
  });
};

$( document ).ready( function(){
  $( "#auto" ).click( function(){
    $( this ).addClass("selected");
    $( "#not-auto" ).removeClass("selected");
  })
});

$( document ).ready( function(){
  $( "#not-auto" ).click( function(){
    $( this ).addClass("selected");
    $( "#auto" ).removeClass("selected");
  })
});

$( document ).ready( function(){
  $( "#quiz-text" ).on( "paste", function(e){
    if( $( "#auto" ).hasClass("selected") ) {
      var pastedText;

      try {
        pastedText = e.originalEvent.clipboardData.getData('text/plain');
      } catch (z) {
        try {
          pastedText = clipboardData.getData('Text');
        } catch (z) {}
      }

      $.ajax({
        type: "POST",
        url: "/auto",
        data: pastedText,
        dataType: "text"
      }).done( function(response){
        document.getElementById("auto-input").value = response
      });
    }
  });
});
