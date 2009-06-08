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
  recalculate_totals();
};

var set_food_item_choice = function(em_id, fi_id) {
  var that = $("li#entrymatch-"+em_id);
  $.ajax({
    url: '/entry_matches/'+em_id+"?format=html",
    type: 'POST',
    dataType: 'script',
    data: {
      '_method': 'PUT',
      'authenticity_token': AUTH_TOKEN,
      'entry_match[food_item_id]': fi_id
    },
    success: function(msg) {
      that.replaceWith(msg)
      $("li#entrymatch-"+em_id).effect("highlight",{},1000);
      recalculate_totals();
    }
  });
};

// Update the calorie count, etc., on the left panel.
// Probably just fire off an ajax request.
var recalculate_totals = function() {
  $.ajax({
    url: '/goals/sidebar',
    type: 'GET',
    success: function(msg) {
      $("#goals").html(msg);
    }
  });
};

var bindevents_alternateselection = function() {
  $('.alternate_fi').click(function(e) {
    var id = $(this).attr('id');
    var spl = id.split('-');
    var fi_id = spl[2];
    var em_id = spl[1];
    set_food_item_choice(em_id, fi_id);

    $(document).trigger('close.facebox');
    e.preventDefault();
  });
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

  recalculate_totals();

});