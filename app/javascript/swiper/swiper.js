document.addEventListener('DOMContentLoaded', () => {
  var swiper = new Swiper('.swiper-container', {
    effect: 'fade',
    spaceBetween: 30,
    centeredSlides: true,
    autoplay: {
      delay: 6000,
      disableOnInteraction: false,
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
  });
});