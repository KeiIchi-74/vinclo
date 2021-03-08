document.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/\/cloth_stores\/\d+/) || document.URL.match(/\/reviews\/create/)) {
    const target = document.getElementById("c-overlay");
    const observer = new MutationObserver(() => {
      if (document.getElementById("rmw-form")) {
        initClothForm();
      }
    });
    const config = {childList: true};
    observer.observe(target, config);
    function initClothForm() {
      let count = 0;
      const registerCount = document.getElementById("register-count")
      const clothFormAddButton = document.querySelector(".cloth-form-add-content");
      const clothFormRemoveButton = document.querySelector(".cloth-form-remove-content");
      if (registerCount.textContent) {
        count = registerCount.textContent - 1;
        console.log(count);
        if (count == 3) {
          clothFormRemoveButton.classList.remove('hidden');
          clothFormAddButton.classList.add('hidden');
        } else if (count != 0) {
          clothFormRemoveButton.classList.remove('hidden');
        }
        registerCount.textContent = "";
      }
      for (let i = 0; i <= count; i ++) {
        document.getElementById(`review_form_cloths_attributes_${i}_register`).setAttribute("checked", "checked");
        document.getElementById(`rmw-main-cloth-container-${i}`).classList.remove("hidden");
      }

      clothFormAddButton.addEventListener("click", () => {
        count = count + 1;
        clothFormRemoveButton.classList.remove("hidden");
        document.getElementById(`review_form_cloths_attributes_${count}_register`).setAttribute("checked", "checked");
        document.getElementById(`rmw-main-cloth-container-${count}`).classList.remove("hidden");
        if (count == 3) {
          clothFormAddButton.classList.add("hidden");
        }
      });

      clothFormRemoveButton.addEventListener("click", () => {
        clothFormAddButton.classList.remove("hidden");
        document.getElementById(`review_form_cloths_attributes_${count}_register`).removeAttribute("checked");
        document.getElementById(`rmw-main-cloth-container-${count}`).classList.add("hidden");
        count = count - 1;
        if (count == 0) {
          clothFormRemoveButton.classList.add("hidden");
        }
      });
    }
  }
});