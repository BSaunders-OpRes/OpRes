$(document).ready(function(){
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
})


document.addEventListener("turbolinks:load", () => { 
  document.querySelector("#myinput_one").oninput = function() {
    var value = (this.value-this.min)/(this.max-this.min)*100
    this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
  };

  document.querySelector("#myinput_two").oninput = function() {
    var value = (this.value-this.min)/(this.max-this.min)*100
    this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
  };
});

