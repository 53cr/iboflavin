if ( window.addEventListener ) {
  var state = 0, konami = [38,38,40,40,37,39,37,39,66,65];
  window.addEventListener("keydown", function(e) {
    if ( e.keyCode == konami[state] ) state++;
    else state = 0;
    if ( state == 10 ) window.location = "http://53cr.com/secret";
  }, true);
}

var configureRPX = function() {
  RPXNOW.token_url = 'http://'+location.host+'/rpx/login',
  RPXNOW.realm = "iboflavin";
  RPXNOW.default_provider = "twitter";
  RPXNOW.overlay = true;
  RPXNOW.language_preference = 'en';
};

var handleMessage = function(response, statusText) {
  $("#recent").prepend(response);
  $("#recent .entry:first").effect("highlight",{},1500);
};

var bind_editors = function() {
  $(".in-place-edit").editable('/entry_matches/update_amount', {

  });
};

$(document).ready(function() {

  bind_editors();

  $('#cloud').animate({
    "background-position": "707px"
  }, 150000, "linear");

  var def = "Four Pan-Galactic Gargle Blasters";

  $("#thequestion form").ajaxForm({success: handleMessage, clearForm: true});

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