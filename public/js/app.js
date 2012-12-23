Eol = {};

Eol.onPageLoad = function() {
  // _.each(document.getElementsByClassName('num'), function(number) {
  //   number.innerHTML = Num.format(number.innerHTML);
  // });
};

Eol.onPageLoad();

// window.mySwipe = new Swipe(document.getElementById('slider'));

// Set up PhotoSwipe with all anchor tags in the Gallery container
document.addEventListener('DOMContentLoaded', function(){
  var swipe = Code.PhotoSwipe.attach(
    window.document.querySelectorAll('#swipe-gallery a'),
    { allowUserZoom: true
    , captionAndToolbarOpacity: 0.6
    }
  );
}, false);
