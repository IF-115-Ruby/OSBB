$(window).on("load", function () {
  showHideCheckboxFields('#newOsbb', ['#OsbbName', '#OsbbPhone', '#OsbbEmail', '#OsbbWeb']);
  showHideCheckboxFields('#searchOsbb', ['#OsbbSearch']);
});

function showHideCheckboxFields(checkboxId, checkboxArrayId) {
  let test = localStorage.input === 'true';

  $(checkboxId).prop('checked', test || false);
  flagIsChecked();

  $(document).on('change', checkboxId, function () {
    localStorage.input = $(this).is(':checked');
    flagIsChecked();
  });

  $(document).on("click", "[type='checkbox']", function (e) {
    $(this).attr("value", this.checked);
  });

  function flagIsChecked() {
    const isSearchOsbb = $('#searchOsbb').prop("checked");
    const isNewOsbb = $('#newOsbb').prop("checked");
    $('#searchOsbb').attr('disabled', isNewOsbb);
    $('#newOsbb').attr('disabled', isSearchOsbb);
    
    if ($(checkboxId).prop('checked')) {
      checkboxArrayId.map(item => {
        $(item).addClass('d-flex');
      })
    } else {
      checkboxArrayId.map(item => {
        $(item).removeClass('d-flex');
      })
    }
  }
}
