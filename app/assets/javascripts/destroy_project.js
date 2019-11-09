$( document ).on('turbolinks:load', function() {
  $('.del-project').click(function(){
    let x = $(this).data('id');
    let response = confirm("Are you sure you want to delete this project?");

    if (response){
      $.ajax({
        type: "DELETE",
        url: "/projects/" + x,
        dataType: "JSON"
      }).done(function(res){
        $("#project-" + x).fadeOut(300, function(){
          $(this).remove();
          toastr.success(res.status)
        });
      });
    }
  });
});
