$(".about-button").click(function() {
    $.ajax({
    url: "/about"
  }).done(function( html ) {
      $(".about-text").empty().html( html );
    });
});