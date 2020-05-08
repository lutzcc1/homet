

$('#meals-carousel').carousel({
  interval: 3500
})

$('.carousel-control-prev').click(function() {
  $('#meals-carousel').carousel('prev');
});

$('.carousel-control-next').click(function() {
  $('#meals-carousel').carousel('next');
});
