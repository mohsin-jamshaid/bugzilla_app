$(document).on('click', '.del-project', function (event) {
  let project_id = $(this).data('id');
  let response = confirm("Are you sure you want to delete this project?");

  if (response){
    $.ajax({
      type: "DELETE",
      url: "/projects/" + project_id,
      dataType: "JSON",
      success: function(res){
        toastr.success("Project has been successfully destroyed");  
      },
      error: function(res){
        toastr.error("Failed to destroy project, try again later");  
      }
    });
  }
});