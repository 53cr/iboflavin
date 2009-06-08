if ( window.addEventListener ) {
  var state = 0, konami = [38,38,40,40,37,39,37,39,66,65];
  window.addEventListener("keydown", function(e) {
    if ( e.keyCode == konami[state] ) state++;
    else state = 0;
    if ( state == 10 ) window.location = "http://53cr.com/secret";
  }, true);
}

var handleMessage = function(response, statusText) {
  $("#recent").prepend(response);
  $("#recent .entry:first").effect("highlight",{},1500);
};

var bindevents_newentry = function() {
  // In place editing for Quantifiers in Entry listings
  $(".in-place-edit.unevented").each(function(el) {
    var id = $(this).attr('id');
    id = id.split('-')[1];
    $(this).editable('/entry_matches/'+id+'?format=js', {
      name: 'entry_match[value]',
      method: 'PUT',
      submitdata: {
        authenticity_token: AUTH_TOKEN,
        wants: 'amount'
      }
    }).removeClass("unevented");
  });

//   $(".editable.fooditem.unevented").each(function(el) {
//     var id = $(this).closest("li.removeable").attr('id');
//     id = id.split('-')[1];
//     $(this).click(function(e) {
//       alert('click');

//       e.preventDefault();
//     });
//   }).removeClass("unevented");

  $(".editable.fooditem.unevented").each(function(el) {
    $(this).children("a").facebox();
  }).removeClass("unevented");



  // Mouseover effect for swapping on/off versions of close 'X'
  $(".delete_x.unevented").mouseover(function(){
    $(this).children('a').children('.off').hide();
    $(this).children('a').children('.on').show();
  }).mouseout(function(){
    $(this).children('a').children('.on').hide();
    $(this).children('a').children('.off').show();
  });
  // Bind the close link to remove via ajax, then remove the element from the DOM.
  $(".delete_x.unevented a").click(function(e){
    var that = this;
    $.ajax({
      url: $(this).attr('href'),
      type: 'POST',
      dataType: 'script',
      data: {
        '_method': 'delete',
        'authenticity_token': AUTH_TOKEN
      },
      success: function(msg) {
        $(that).closest(".removeable").hide('slow',function(){
          $(this).remove();
        });
      }
    });
    return false;
  });
  // Don't add more events to this element later :)
  $(".delete_x.unevented").removeClass("unevented");
};

$(document).ready(function() {

  bindevents_newentry();

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