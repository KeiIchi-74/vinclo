document.addEventListener('DOMContentLoaded', () => {
  if (document.URL.match(/\/cloth_stores\/\d+/) || document.URL.match(/\/reviews\/create/)) {
    const stars = document.getElementsByClassName("fa-star");
    const scoreValue = document.getElementById("score-value");
    const scoreValueDisplay = document.getElementById("score-value-display");
    if (scoreValue.value) {
      for(let i = 0; i < scoreValue.value; i++) {
        stars[i].classList.remove("far");
        stars[i].classList.add("fas");
        scoreValueDisplay.textContent = scoreValue.value;
      }
    }
    for(let i = 0; i < stars.length; i++) {
      stars[i].addEventListener('mouseover', () => {
        for(let j = 0; j < stars.length; j++) {
          stars[j].classList.remove("fas");
          stars[j].classList.add("far");
        }
        for(let j = 0; j <= i; j++) {
          stars[j].classList.remove("far");
          stars[j].classList.add("fas");
          scoreValue.value = i + 1;
          scoreValueDisplay.textContent = scoreValue.value;
        }
      })
      stars[i].addEventListener("click", () => {
        scoreValue.value = i + 1;
        scoreValueDisplay.textContent = scoreValue.value;
      })
      stars[i].addEventListener("mouseout", () => {
        for(let j = 0; j < stars.length; j++) {
          stars[j].classList.remove("fas");
          stars[j].classList.add("far");
        }
        for(let j = 0; j <= i; j++) {
          stars[j].classList.remove("far");
          stars[j].classList.add("fas");
          scoreValue.value = i + 1;
          scoreValueDisplay.textContent = scoreValue.value;
        }
      })
    }
  }
});