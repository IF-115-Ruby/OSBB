$(document).on("turbolinks:load", function () {
  $("#arrow-down").click(function(){
    $(".user-form .osbb_search_form").slideToggle();
    $(".user-osbb-edit-box__item-up").slideToggle();
  });
});
