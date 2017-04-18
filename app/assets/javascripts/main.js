$(document).ready(function() {
  $('.idea-title').on('click', function() {
    if ($(event.currentTarget.children).eq(1).hasClass('show-idea-body')) {
      $(event.currentTarget.children).eq(1).slideUp(500, function() {
        $(this).removeClass('show-idea-body');
      });
    } else {
      $(event.currentTarget.children).eq(1).slideDown(500, function() {
        $(this).addClass('show-idea-body');
      });
    }
  });

});
