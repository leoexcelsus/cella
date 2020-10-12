// to do: this function no longer is called in application.js and the reason why
// is therein explained.
const selectPolygon = () => {
  const formGeoInputOptionTwo = document.getElementById('geom-input-option');
  if (formGeoInputOptionTwo) {
    window.addEventListener("load", (event) => {
      document.getElementById('form-file').hidden = true;
      document.getElementById('form-polygon').hidden = true;
    });
    formGeoInputOptionTwo.addEventListener('input', (event) => {
      console.log("Geometry input option is set");
      const formFile = document.getElementById('form-file');
      const formPolygon = document.getElementById('form-polygon');
      if (formGeoInputOptionTwo.value == "load") {
        formFile.hidden = true;
        formPolygon.hidden = false;
      } else if (formGeoInputOptionTwo.value == "upload") {
        formFile.hidden = false;
        formPolygon.hidden = true;
      } else {
        formFile.hidden = true;
        formPolygon.hidden = true;
      };
    });
  }
}

export { selectPolygon }
