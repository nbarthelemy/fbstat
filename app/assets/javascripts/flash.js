// $.flash('success', 'Wowie Zowie you were successful!');
// $.flash('error', 'ERRRRRRRRT Wrong!');
// $.flash('warning', 'Be afraid!');

(function($, undefined){

  var execIf = function(v){
    return typeof v == 'function' ? v() : v;
  };

  var timeout, queue = [];
  var show = function(){
    var o = queue[0];

    timeout = setTimeout('$.flash.hide()', o.time);

    var elm = $('<div/>').attr('id', o.id).addClass([ 'flash', o.type ].join(' ')).hide();
    var msg = $('<span/>').html(o.message);
    elm.append(msg.wrap('<p/>').parent());

    elm.click(function(){ $.flash.hide() });
    elm[execIf(o.attachmentMethod)]($(execIf(o.attachmentElement))).fadeIn('fast');
  };

  var flashOptionsFromDOM = function(){
    var opts = {};
    if( $('[data-flash]').length > 0 ){
      var $elem = $('[data-flash]').first();
      opts = $.extend({ attachmentElement: $elem }, $elem.data('flash'));
    }
    return opts;
  };

  $.flash = function(type, message, options){
    queue.push($.extend({}, $.flash.defaults, {
      'type'    : type,
      'message' : message,
      'time'    : 3000
    }, flashOptionsFromDOM(), options));

    return queue.length > 1 || show();
  };

  $.flash.hide = function(){
    if( !$('#flash').length ) return;
    clearTimeout(timeout);
    $('.flash').fadeOut('fast', function(){
      $(this).remove();
      queue.shift();
      if( queue.length > 0 ) show();
    });
  };

  $.flash.defaults = {
    id: 'flash',
    attachmentMethod: 'prependTo',
    attachmentElement: 'body'
  };

})(jQuery);