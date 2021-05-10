document.addEventListener('turbolinks:load', function() {

  $('[data-toggle="tooltip"]').tooltip();

  $('#close_sidebar').click(function() {
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
  });

  $('#open_sidebar').click(function() {
    $('.sidebar').css('width', '290');
    $('.content').addClass('blur');
    $('.header').addClass('blur');
  });

  if ($('#myinput_one').length >= 1) {
    var demo = $('#demo1')
    document.querySelector("#myinput_one").oninput = function() {
      var value = (this.value-this.min)/(this.max-this.min)*100
      this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
      demo.value= this.value;
      $('#demo1').val(demo.value);
    };
  }

  if ($('#myinput_two').length >= 1) {
    var demo2 = $('#demo2')
    document.querySelector("#myinput_two").oninput = function() {
      var value = (this.value-this.min)/(this.max-this.min)*100
      this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
      demo2.value= this.value;
      $('#demo2').val(demo2.value);
    };
  }

});

