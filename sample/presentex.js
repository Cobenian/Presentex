$( document ).ready(function() {

  $("body").keydown(function(e) {
    if(e.keyCode == 37) { // left
      console.log('left');
      var slide = $('.slide:visible');
      var w = "+=" +  (slide.width() * 3);
      if ( slide.prev('.slide').length > 0 ) {
        slide.animate({
          left: w
        }, function() {
          slide.hide().css({'left': 0});
          slide.prev('.slide').css({'left': 0}).show();
        });
      }
    }
    else if(e.keyCode == 39) { // right
      console.log('right');
      var slide = $('.slide:visible');
      var w = "-=" + (slide.width() * 3);
      if ( slide.next('.slide').length > 0 ) {
        slide.animate({
          left: w
        }, function() {
          slide.hide().css({'left': 0});
          slide.next('.slide').css({'left': 0}).show();
        });
      }
    }
  });

  $(".slide").first().show();

  $('body').flowtype({
   minimum   : 500,
   maximum   : 1200,
   minFont   : 12,
   maxFont   : 35,
   fontRatio : 30
  });


});
