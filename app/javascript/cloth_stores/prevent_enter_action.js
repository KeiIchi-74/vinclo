document.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/\/cloth_stores\/new/) || document.URL.match(/\/cloth_stores\/create/)) {
    const clothStoreCreateForm = document.getElementById("cloth-store-create-form");
    clothStoreCreateForm.addEventListener('keydown', (e) => {
      const key = e.key;
      if (key == 'Enter') {
        e.preventDefault();
      }
    })
  }
});