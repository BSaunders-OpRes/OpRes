document.addEventListener('turbolinks:load', function() {
  /******************** Page Load Logics ********************
  **********************************************************/
  if ($('#onboarding-finish').length >0) {
    setTimeout(function() {
      window.location.href = '/organisation/dashboard';
    }, 2000);
  }

  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('click', '.build-institution', function() {
    link              = $(this);
    institution_block = link.parents('.institution-block');
    institution_index = institution_block.find('.card').length;

    $.ajax({
      url:  link.data('target'),
      type: 'GET',
      data: {
        institution: link.data('institution'),
        index:       institution_index
      }
    });
  });

  $('body').on('click', '.build-user-invitation', function() {
    link         = $(this);
    invite_index = $('#user-invitation .user-invitation-child').length

    $.ajax({
      url:  link.data('target'),
      type: 'GET',
      data: {
        index: invite_index
      }
    });
  });

  $('body').on('click', '#select-all-countries', function() {
    if(this.checked) {
      $('#countries-partial .country').prop('checked', true);
    } else {
      $('#countries-partial .country').prop('checked', false);
    }
  });

  $('body').on('keypress', '#country-setup-form', function(e) {
    if (e.keyCode == 13) {
      return false;
    }
  });

  $('body').on('keyup', '#country-search-filter', function() {
    var value = $(this).val().toLowerCase();
    $('#countries-partial .country-list').filter(function(index, ele) {
      $(this).toggle($(ele).text().toLowerCase().indexOf(value) > -1)
    });
  });

  $('body').on('click', '.invite-user-step-next', function() {
    $('#invite-user-tabs #send-invitation').click();
  });

  $('body').on('click', '#journey-save-exit-institutions', function() {
    form = $(this).parents('form');
    action = form.attr('action').replace('invite_user', 'country_setup');
    form.attr('action', action);
    $('#journey-submit-institutions').click();
  });

  $('body').on('click', '#journey-save-exit-countries', function() {
    form = $(this).parents('form');
    action = form.attr('action').replace('country_setup', 'account_setup');
    form.attr('action', action);
    $('#journey-submit-countries').click();
  });
  
  $('body').on('click','#save-channels',function() {
    dataTarget = $('[data-target="' + $(this).attr('data-id') + '"]');
    channelContent = $(dataTarget).parent();
    selectedChannels = $(this).closest('.modal').find('input:checkbox:checked');
    selectedChannelsArr = [];

    $(selectedChannels).each(function() {
      selectedChannelsArr.push($(this).val());
    });

    if ( selectedChannelsArr.length > 0 ) {
      selectedChannelsText = selectedChannelsArr.reverse().pop();
      if ( selectedChannelsArr.length >= 1 ) {
        selectedChannelsText += ", " + selectedChannelsArr.reverse().pop();
      }

      if ( selectedChannelsArr.length >= 1 ) {
        selectedChannelsText += " + " + selectedChannelsArr.length + " More";
      }
      
      channelContent.find(' > span').remove();
      channelContent.prepend('<span class="text-left font-12 font-600">' + selectedChannelsText + '</span>');
      dataTarget.find('i').remove();
      dataTarget.find('span').text('EDIT').addClass('ml-sm-2 ml-0 mt-sm-0 mt-2').removeClass('ml-2');
    } else {
      channelContent.find(' > span').remove();
      dataTarget.prepend('<i class="fa fa-plus-circle"></i>');
      dataTarget.find('span').text('Add Channels');
    }
  });

  $('body').on('click','.add-product',function(){
    channel_id = '#'+this.id+'-channel';
    if ($(this).is(':checked')) {
      $(channel_id).removeClass('disable');
    } else {
      $(channel_id).addClass('disable');
    }
  });
});
