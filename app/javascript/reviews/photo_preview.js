document.addEventListener('turbolinks:load', () => {
  if (document.URL.match(/\/cloth_stores\/\d+/) || document.URL.match(/\/reviews\/create/)) {
    const target = document.getElementById("c-overlay");
    const observer = new MutationObserver(() => {
      if (document.getElementById("rmw-form")) {
        photoPreview();
      }
    });
    const config = {childList: true};
    observer.observe(target, config);
    function photoPreview() {
      const token = document.getElementsByName("csrf-token")[0].content;
      const inputFile = document.getElementById("review_form_review_images");
      const photoPreviewArea = document.getElementById("photo-preview-area");
      const photoPreviewCount = document.querySelectorAll(".photo-preview").length;
      const photoPreviewInfo = document.getElementById("photo-preview-info");
      addHiddenOfImageAddBtn(photoPreviewCount);
      addHiddenOfPhotoPreviewInfo(photoPreviewInfo, photoPreviewCount);
      inputFile.addEventListener("change", e => {
        const photoPreviewCount = document.querySelectorAll(".photo-preview").length;
        createImages(e, photoPreviewCount);
        inputFile.value = '';
      })
      photoPreviewArea.addEventListener("click", (e) => {
        editImageInputClick(e);
        deletePhotoPreview(e);
        inputFileClick(e);
      });
      photoPreviewArea.addEventListener("change", (e) => {
        if (e.target.className == "edit-image-file-input hidden") {
          const editImageFileInput = e.target;
          const photoPreview = editImageFileInput.closest(".photo-preview");
          const file = e.target.files[0];
          const blob = window.URL.createObjectURL(file);
          uploadFile(file).then(
            (image_id) => {
              replaceImage(image_id, photoPreview, blob);
              editImageFileInput.value = '';
            }
          );
        }
      });
      
      function createImages(e, imageCount) {
        const files = e.target.files;
        const totalImageCount = imageCount + files.length;
        if (totalImageCount > 4) {
          alert("添付できる画像は合計で4枚までです。");
          return;
        } 
        Object.keys(files).forEach((key, index) => {
          const blob = window.URL.createObjectURL(files[key]);
          const img = createImageHTML(blob);
          uploadFile(files[key]).then(
            (image_id) => {
              createHTML(img, image_id);
              addHiddenOfImageAddBtn(totalImageCount);
              // photo-preview-infoにhiddenをつける関数を、プレビュー描画が行われる最初の一回だけ実行するための条件
              if (index == 0 && imageCount == 0) {
                const photoPreviewCount = document.querySelectorAll(".photo-preview").length;
                addHiddenOfPhotoPreviewInfo(photoPreviewInfo, photoPreviewCount);
              }
            }
          );
        });
      }
      function createImageHTML(blob) {
        const img = document.createElement("img");
        img.setAttribute("src", blob);
        return img;
      }
      function uploadFile(imageFile) {
        return new Promise((resolve, reject) => {
          const formData = new FormData();
          formData.append("image", imageFile);
          const XHR = new XMLHttpRequest();
          XHR.open("POST", "/reviews/upload_image", true);
          XHR.responseType = "json";
          XHR.setRequestHeader("X-CSRF-Token", token);
          XHR.send(formData);
          XHR.onload = () => {
            if (XHR.status != 200) {
              alert(`アップロードできませんでした。 ${XHR.status}: ${XHR.statusText}`);
              reject();
            } else {
              resolve(XHR.response.image_id);
            }
          }
        });
      }
      function replaceImage(image_id, element, blob) {
        const img = element.querySelector("img");
        const input = element.querySelector(".image-id-input");
        img.setAttribute("src", blob);
        input.setAttribute("value", image_id);
      }
      function addHiddenOfImageAddBtn(imageCount) {
        const imageAddBtn = document.getElementById("photo-add-box");
        if (imageCount == 4) {
          imageAddBtn.classList.add("hidden");
        }
      }
      function addHiddenOfPhotoPreviewInfo(element, count) {
        if (count) {
          element.classList.add("hidden");
        }
      }
      function removeHiddenOfImageAddBtn() {
        const imageAddBtn = document.getElementById("photo-add-box");
        if (imageAddBtn.className == "hidden") {
          imageAddBtn.classList.remove("hidden");
        }
      }
      function removeHiddenOfPhotoPreviewInfo(count) {
        if (count == 0) {
          photoPreviewInfo.classList.remove("hidden");
        }
      }
      function editImageInputClick(e) {
        if (e.target.className == "edit-icon") {
          const editText = e.target;
          const photoPreview = editText.closest(".photo-preview");
          const editImageFileInput = photoPreview.querySelector(".edit-image-file-input");
          editImageFileInput.click();
        }
      }
      function deletePhotoPreview(e) {
        if (e.target.className == "delete-icon") {
          const deleteText = e.target;
          const photoPreview = deleteText.closest(".photo-preview");
          photoPreview.remove();
          removeHiddenOfImageAddBtn();
          const photoPreviewCount = document.querySelectorAll(".photo-preview").length;
          removeHiddenOfPhotoPreviewInfo(photoPreviewCount);
        }
      }
      function inputFileClick(e) {
        if (e.target.id == "photo-add-box") {
          inputFile.click();
        }
      }
      function createHTML(img, image_id) {
        const li = document.createElement("li");
        li.classList.add("photo-preview");
        const divContainer = document.createElement("div");
        divContainer.classList.add("photo-preview-container");
        const divDeleteIcon = document.createElement("div");
        divDeleteIcon.classList.add("delete-icon");
        divDeleteIcon.textContent = '✕';
        const divEditIcon = document.createElement("div");
        divEditIcon.classList.add("edit-icon");
        divEditIcon.textContent = '編集';
        const editImageInput = document.createElement("input");
        editImageInput.setAttribute("class", "edit-image-file-input hidden");
        editImageInput.setAttribute("type", "file");
        editImageInput.setAttribute("accept", "image/*");
        const imageIdInput = document.createElement("input");
        imageIdInput.setAttribute("class", "image-id-input");
        imageIdInput.setAttribute("type", "hidden");
        imageIdInput.setAttribute("name", "review_form[review_images][]");
        imageIdInput.setAttribute("value", image_id);
        const divWrap = document.createElement("div");
        divWrap.classList.add("photo-preview-wrap");
        divWrap.appendChild(img);
        divContainer.appendChild(divDeleteIcon);
        divContainer.appendChild(divEditIcon);
        divContainer.appendChild(editImageInput);
        divContainer.appendChild(imageIdInput);
        divContainer.appendChild(divWrap);
        li.appendChild(divContainer);
        const photoAddBox = document.getElementById("photo-add-box");
        photoAddBox.before(li);
      }
    }
  }
});