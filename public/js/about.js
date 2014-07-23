

$(".about-button").click(function() {
    $.ajax({
    url: "/about"
  }).done(function( html ) {
      $(".about-text").empty().html( html );
    });
});

$(".container").on('click', "#choiceA", function() {
  console.log("clicked choice A")
    var page_id = $("h1").data('id')
    $.ajax({
    type: "POST",
    url: "/adventure",
    data: { selection: "A", id: page_id}
  }).done(function( html ) {
      console.log(html);
      $(".adventure").empty().html( html );
    });
});

$(".container").on('click', "#choiceB", function() {
  console.log("clicked choice B")
    var page_id = $("h1").data('id')
    $.ajax({
    type: "POST",
    url: "/adventure",
    data: { selection: "B", id: page_id}
  }).done(function( html ) {
      console.log(html);
      $(".adventure").empty().html( html );
    });
});