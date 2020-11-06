$(window).on("load",function(){
  let test = localStorage.input === 'true';
  $('#newOsbb').prop('checked', test || false);
  flagIsChecked();
});
$(document).on('change','#newOsbb', function() {
  localStorage.input = $(this).is(':checked');
  flagIsChecked();
});
$(document).on("click", "[type='checkbox']", function(e) {
  if (this.checked) {
    $(this).attr("value", "true");
  } else {
    $(this).attr("value","false");}
  });
function flagIsChecked() {
  console.log("dd")
  if($('#newOsbb').prop('checked')) {
    $('#OsbbName, #OsbbPhone, #OsbbEmail, #OsbbWeb').addClass('d-flex')
  } else {
    $('#OsbbName, #OsbbPhone, #OsbbEmail, #OsbbWeb').removeClass('d-flex')
  }
}
