$(window).on("load",function(){
  let test = localStorage.input === 'true';
  $('#flag').prop('checked', test || false);
  FlagIsChecked();
});
$(document).on('change','#flag', function() {
  localStorage.input = $(this).is(':checked');
  FlagIsChecked();
});
$(document).on("click", "[type='checkbox']", function(e) {
  if (this.checked) {
    $(this).attr("value", "true");
  } else {
    $(this).attr("value","false");}
  });
function FlagIsChecked() {
  console.log("dd")
  if($('#flag').prop('checked')) {
    $('#OsbbName, #OsbbPhone, #OsbbEmail, #OsbbWeb').addClass('d-flex')
  } else {
    $('#OsbbName, #OsbbPhone, #OsbbEmail, #OsbbWeb').removeClass('d-flex')
  }
}