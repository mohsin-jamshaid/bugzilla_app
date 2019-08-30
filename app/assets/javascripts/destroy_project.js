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

          const str = '<div class="alert alert-success alert-dismissible fade show" role="alert">'
                        +'Project has been successfully destroyed'
                        +'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
                        +'<span aria-hidden="true">&times;</span></button></div>'
          $("#flash").prepend(str);
        });
      });
    }
  });
});
