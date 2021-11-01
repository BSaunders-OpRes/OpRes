  document.addEventListener('turbolinks:load', function() {
  // get all folders in our .directory-list
  var allFolders = $(".directory-list li > ul");
  allFolders.find('.third-level').css('display', 'none')
  allFolders.each(function() {

    // add the folder class to the parent <li>
    var folderAndName = $(this).parent();
    folderAndName.addClass("folder");

    // backup this inner <ul>
    var backupOfThisFolder = $(this);
    // then delete it
    $(this).remove();
    // add an <a> tag to whats left ie. the folder name
    folderAndName.wrapInner("<a href='#' />");
    // then put the inner <ul> back
    folderAndName.append(backupOfThisFolder);
    let minusSign = $('.folder').find('fa-plus-circle');
    // now add a slideToggle to the <a> we just added
    folderAndName.find("a").click(function(e) {
      $(this).siblings("ul").slideToggle();
      $(this).find('i').toggleClass('fa-minus-circle fa-plus-circle')
      e.preventDefault();
    });

  });
});
