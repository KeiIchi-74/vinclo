document.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/\/cloth_stores\/\d+/) || document.URL.match(/\/reviews\/create/)) {
    const target = document.getElementById("c-overlay");
    const observer = new MutationObserver(() => {
      if (document.getElementById("rmw-form")) {
        countTextNumber();
      }
    });
    const config = {childList: true};
    observer.observe(target, config);
    function countTextNumber() {
      const titleTextarea = document.getElementById("rmw-main-title-textarea");
      const titleCount = document.getElementById("title-count");
      const textTextarea = document.getElementById("rmw-main-text-textarea");
      const textCount = document.getElementById("text-count");
      titleTextarea.addEventListener('input', () => {
        setCount(titleTextarea, titleCount, 50);
      });
      textTextarea.addEventListener('input', () => {
        setCount(textTextarea, textCount, 5000);
      });
      function setCount(textarea, countArea, limitNum) {
        const inputValue = textarea.value;
        const inputLength = inputValue.length;
        countArea.textContent = inputLength;
        setMaxCount(inputLength, countArea, limitNum);
      }
      function setMaxCount(inputLength, countArea, limitNum) {
        if (inputLength > limitNum) {
          countArea.textContent = limitNum;
        }
      }
    }
  }
});