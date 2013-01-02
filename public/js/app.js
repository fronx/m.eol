JS.Packages(function() { with(this) {
    file('/js/klass.min.js')
        .provides('klass');

    file('/js/code.photoswipe-3.0.5.min.js')
        .provides('Code.Util')
        .provides('Code.PhotoSwipe')
        .uses('klass');
}});

// window.mySwipe = new Swipe(document.getElementById('slider'));
// Set up PhotoSwipe with all anchor tags in the Gallery container
document.addEventListener('DOMContentLoaded', function(){
    JS.require('Code.PhotoSwipe', function() {
        var swipe = Code.PhotoSwipe.attach(
                window.document.querySelectorAll('#swipe-gallery a'),
                { allowUserZoom: true
                , captionAndToolbarOpacity: 0.6
                , minUserZoom: 1.0
                , swipeThreshold: 100
                , preventSlideshow: true
                , margin: 40
                }
            );
    });
}, false);
