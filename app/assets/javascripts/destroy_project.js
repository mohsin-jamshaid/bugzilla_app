$( document ).on('turbolinks:load', function() {
  $('.del-project').click(function(){
    var x = $(this).data('id');
    var response = confirm("Are you sure you want to delete this project?");

    if (response){
      $.ajax({
        type: "DELETE",
        url: "/projects/" + x,
        dataType: "JSON"
      }).done(function(res){
        $("#project-" + x).fadeOut(300, function(){
          $(this).remove();
        });
      });
    }
  });
});
