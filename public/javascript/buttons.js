$( document ).ready( function() {
  $( "#quiz-form" ).submit(function(event) {
    $( "#submit-btn" ).button("loading")
    $( "#download-link" ).addClass("disabled")
    data = $( "#quiz-form" ).serialize();
    $.ajax({
      type: "POST",
      url: "/",
      data: data,
      dataType: "html",
      timeout: 10000
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
