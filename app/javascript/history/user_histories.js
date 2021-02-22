document.addEventListener('turbolinks:load', () => {
  const UserHistoriesTitleItems = document.querySelectorAll('.user-histories-title');
  const UserHistoriesContainers = document.querySelectorAll('.user-histories-container');

  UserHistoriesTitleItems.forEach(clickedItems => {
    clickedItems.addEventListener('click', e => {
      e.preventDefault();

      UserHistoriesTitleItems.forEach(item => {
        item.classList.remove('user-histories-title-is-active');
      });
      clickedItems.classList.add('user-histories-title-is-active');

      UserHistoriesContainers.forEach(container => {
        container.classList.add('user-histories-container-not-active');
      });
      document.getElementById(clickedItems.dataset.id).classList.remove('user-histories-container-not-active');
    });
  });
});