$(document).ready(function(){
  $('.newcomment').click(function(){
    $('.no-comment').hide();
    $('.current-comments').hide();
    $('.make-comment').fadeIn();
  });

  $('.cancel').on("click",function(){
    $('.no-comment').fadeIn();
    $('.current-comments').fadeIn();
    $('.make-comment').hide();
    $('.edit_container').hide();
  });

});
