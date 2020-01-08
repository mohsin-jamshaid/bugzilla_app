App.project = App.cable.subscriptions.create "ProjectChannel",
  connected: ->
    display_projects()

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#project-#{data.id}").fadeOut 300, ->
      $(this).remove()
      display_projects()
      

  display_projects = () ->
    if $('.projects_table >tbody >tr').length == 0
      $('.projects_table').hide()
      toastr.info('You have no Projects yet!')
      $(".projects").append("<p>You've no projects yet !</p>")


