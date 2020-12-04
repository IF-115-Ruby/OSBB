$(window).on("load", function () {
  someFunction('#newOsbb', ['#OsbbName', '#OsbbPhone', '#OsbbEmail', '#OsbbWeb']);
  someFunction('#searchOsbb', ['#OsbbSearch']);
});

function someFunction(checkboxId, checkboxArrayId) {
  let test = localStorage.input === 'true';
  $(checkboxId).prop('checked', test || false);
  flagIsChecked();
  $(document).on('change', checkboxId, function () {
    localStorage.input = $(this).is(':checked');
    flagIsChecked();
  });
  $(document).on("click", "[type='checkbox']", function (e) {
    if (this.checked) {
      $(this).attr("value", "true");
    } else {
      $(this).attr("value", "false");
    }
  });
  function flagIsChecked() {
    if ($(checkboxId).prop('checked')) {
      checkboxArrayId.map(item => {
        $(item).addClass('d-flex')
      })
    } else {
      checkboxArrayId.map(item => {
        $(item).removeClass('d-flex')
      })
    }
  }
}
