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

  $('#bsl-tab li').click(function() {
    href  = $(this).find('a').attr('href');
    parts = href.split('-');
    parts.splice(-1);
    parts.push('desc');
    desc = parts.join('-');

    $('#bsl-desc p').addClass('d-none');
    $(desc).removeClass('d-none');
  });

  $('body').on('click', '.faded-popover-wrapper .faded-popover-title', function() {
    $('.faded-popover-wrapper .faded-popover-content').addClass('d-none');
    $('.faded-popover-wrapper .faded-popover-title .faded-popover-expandable-text').removeClass('faded-popover-expand-text');
    $(this).siblings('.faded-popover-content').removeClass('d-none');
    $(this).find('.faded-popover-expandable-text').addClass('faded-popover-expand-text');
  });

  $('body').on('click', '.faded-popover-wrapper .faded-popover-content .faded-popover-close', function() {
    $(this).parents('.faded-popover-content').addClass('d-none');
    $(this).parents('.faded-popover-content').siblings('.faded-popover-title').find('.faded-popover-expandable-text').removeClass('faded-popover-expand-text');
  });

  $('body').on('click', '.accordion-wrapper .accordion-arrow', function() {
    accordion_content = $(this).parent('.accordion-title').siblings('.accordion-content');
    if (accordion_content.hasClass('d-none')) {
      accordion_content.removeClass('d-none');
      $(this).find('a i').removeClass('fa-angle-down').addClass('fa-angle-up');
    } else {
      accordion_content.addClass('d-none');
      $(this).find('a i').removeClass('fa-angle-up').addClass('fa-angle-down');
    }
  });

  $('body').on('change', '#business_service_line_region', function() {
   $.ajax({
      url: "/organisation/business_service_lines/:"+ $(this).val()+"/find_countries",
      type: "GET",
      data: {region_id: $(this).val()},
    })
  });

  $('body').on('change', '#business_service_line_country', function() {
    $.ajax({
      url: "/organisation/business_service_lines/:"+ $(this).val()+"/find_institutions",
      type: "GET",
      data: {country_id: $(this).val()},
    })
  });

  $('body').on('change', '#business_service_line_institution', function() {
    $.ajax({
      url: "/organisation/business_service_lines/:"+ $(this).val()+"/find_channels_products",
      type: "GET",
      data: {institution_id: $(this).val()},
    })
  });


  $('#proceed-btn').click(function(e){
    e.preventDefault();

    $("#about-tab").validate({
      rules: {
        'business_service_line[name]': {
          required: true,
          minlength: 20
         }
      }
    });


    var current_tab = $('.nav-tabs .active');
    var next_tab_li = current_tab.next('li');
    var next_tab    = current_tab.next('li').find('a');

    if(current_tab.find('a').attr('href')== '#risk-tab'){
      return;
    }
    else if(next_tab.length>0){
      next_tab_li.addClass('active');
      next_tab.trigger('click');
      current_tab.removeClass('active');
    }else{
      $('.nav-tabs li:eq(0) a').trigger('click');
    }
  });

   $('#previous-btn').click(function(e){
    e.preventDefault();
    var current_tab = $('.nav-tabs > .active');
    var previous_tab_li = current_tab.prev('li');
    var previous_tab    = current_tab.prev('li').find('a');
    if(previous_tab.length>0){
      current_tab.removeClass('active');
      previous_tab_li.addClass('active');
      previous_tab.trigger('click');
    }else{
      $('.nav-tabs li:eq(0) a').trigger('click');
    }
  });
  var demo = $('#demo1')
  var demo2 = $('#demo2')
  if ($('#myinput_one').length >= 1) {
    document.querySelector("#myinput_one").oninput = function() {
      var value = (this.value-this.min)/(this.max-this.min)*100
      this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'

      demo.value= this.value;
      $('#demo1').val(demo.value);

    };
  }

  if ($('#myinput_two').length >= 1) {
    document.querySelector("#myinput_two").oninput = function() {
      var value = (this.value-this.min)/(this.max-this.min)*100
      this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
      demo2.value= this.value;
      $('#demo2').val(demo2.value);
    };
  }
});

