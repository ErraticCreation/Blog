$(document).ready(function(){

    // Smooth Scrolling
    var $root = $('html, body');
    $('.same-page a').click(function() {
        var href = $.attr(this, 'href');
        $root.animate({
            scrollTop: $(href).offset().top
        }, 500, function () {
            window.location.hash = href;
        });
        return false;
    });

  $('body').scrollspy({ target: '#navbar' });

  $('#toggle-menu').click(function (e) {
    e.preventDefault();
    $('#page-wrapper').toggleClass('menu-displayed');
  });
});
