document.addEventListener('turbolinks:load', function() {
  if ($('#dashboard-tour-modal').length == 1) {
    $('#dashboard-tour-modal').modal('show');
  }

  $('body').on('click', '#dashboard-tour-start', function(){
    $('#dashboard-tour-modal').modal('hide');
    startIntro();
  });

  $('body').on('click', '#dashboard-tour-dont-ask', function(){
    update_visit_status();
  });

  function startIntro(){
    intro = IntroJS();

    intro.setOptions({
      steps: [
        {
          title:   "Your Business Services",
          element: "#bsl-tour",
          intro: "Here you can see all the business services stored in OpRes.",
          position: 'right',
        },
        {
          title:   "Your Account & OpRes Profile",
          element: "#dropdownMenuButton",
          intro: "You can handle your OpRes profile here and securely log-out of the tool.",
          position: 'left'
        },        
        {
          title:   "Search for Key Items in OpRes",
          element: "#header-search-field",
          intro: "Here you search for business services, suppliers and resilience gaps.",
          position: 'bottom'
        },
        {
          title:   "Your Data Segmentation Options",
          element: "#dashboard-segmentation-option",
          intro: "Here you can filter conditions in OpRes to expand or limit your data insights.",
          position: 'bottom'
        },
        {
          title:   "Your System & Supplier Resilience Indicators",
          element: "#system-supplier-resilience-indicator",
          intro: "Here you can see resilience gaps that may exist across your business services.",
          position: 'right'
        },
        {
          title:   " Critical & Important Systems",
          element: "#critical-important-system",
          intro: "Here you can see which systems and suppliers are critical to your business services.",
          position: 'left'
        },
        {
          title:   "Cloud Provider Distribution",
          element: "#cloud-service-provider-breakdown",
          intro: "Here you can see where your systems are hosted and their consumption model.",
          position: 'left'
        },
        { title:   "High Risk Business Services",
          element: "#high-risk-bsl",
          intro: "Here you can see the most at risk business services in your organisation.",
          position: 'right'
        },
        { 
          title:   "Executive Level Resilience Data Points",
          element: "#impact-tolerance",
          intro:   "Here you can see the breakdown of resilience gaps across each tier of your organisation's business services.",
          position: 'left'
        },
        {
          title:   "Navigation Panel",
          element: "#left-navigational-sidebar",
          intro: "Here is where you can navigate to different sections of OpRes.",
          position: 'bottom-right-aligned'
        }
      ],
      hidePrev:  true,
    });

    intro.onbeforechange(function(element) {
      $('.header').css('position', 'absolute');
      $('#close_sidebar').click();

      if (this._currentStep === 1) {
        $('#dropdownMenuButton').click();
      } else if (this._currentStep === 9) {
        $('#open_sidebar').click();
        $('.sidebar').css('z-index', '9999999');
      }
    });

    intro.onafterchange(function(){
      $('.header').css('position', 'fixed');
    });

    intro.oncomplete(function(element){
      $('#close_sidebar').click();
      $('.sidebar').css('z-index', '9999')
      $('.header').css('position','fixed');
      $('#dashboard-tour-end-modal').modal('show');
      update_visit_status();
    });

    intro.start();
  };

  function update_visit_status() {
    $.ajax({
      url:  '/introjs/visited',
      dataType: 'script',
      type: 'POST',
      data: {
        introjs: {
          dashboard: true,
        }
      }
    });
  }
});
