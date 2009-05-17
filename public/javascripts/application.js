$(document).ready(function() {

  $('#cloudpanel').animate({
    "background-position": "707px"
  }, 150000, "linear");

  var def = "Four Pan-Galactic Gargle Blasters";

  $("#thequestion input.text").
    attr('value', def).
      focus(function() {
        if (def == $(this).attr('value'))
          $(this).
            attr('value', '').
            css('color', '#444');
      }).
      blur(function() {
        if ("" == $(this).attr('value'))
          $(this).
            attr('value', def).
            css('color', '#999');
      });

});