$(document).on("turbolinks:load", function () {
  $(".tablinks").each(function () {
    $(this).removeClass('active');
    if ($(this).attr("href") == window.location.pathname) {
      $(this).addClass('active');
    }
  });
});
