jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
  $("#new_comment").submit(function(){
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  })
})

$(document).ready(function() {
  $("#vote_block a").click(function() {
    $.post((this.href), $(this).serialize(), null, "script");
    return false;
  });
});