document.addEventListener("turbolinks:load", () => {
  if (document.URL.match(/\/prefectures\/\d+/)) {
    const citySearchNav = document.querySelector(".ps-side-city-a");
    const mwMain = document.querySelector(".ps-side-area-search-mw");
    citySearchNav.addEventListener("mouseover", () => {
      mwMain.classList.remove("hidden");
      mwMain.addEventListener("mouseover", () => {
        mwMain.classList.remove("hidden");
      });
      mwMain.addEventListener("mouseout", () => {
        mwMain.classList.add("hidden");
      });
    });
    citySearchNav.addEventListener("mouseout", () => {
      mwMain.classList.add("hidden");
    });
  }
});