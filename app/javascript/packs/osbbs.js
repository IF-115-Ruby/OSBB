document.addEventListener("turbolinks:load", function () {
  $input = $('#user_osbb_id');
 
  var options = {
    url: function(phrase) {
      return '/account/osbbs/search.json?term=' + phrase;
    },
    categories: [
      {
        listLocation: 'osbbs',
        maxNumberOfElements: 10
      }
    ],
    getValue: 'name',
    list: {
      showAnimation: {
        type: "slide", //normal|slide|fade
        time: 400,
        callback: function() {}
      },
  
      hideAnimation: {
        type: "slide", //normal|slide|fade
        time: 400,
        callback: function() {}
      },
    }
  }

  $input.easyAutocomplete(options);
});
