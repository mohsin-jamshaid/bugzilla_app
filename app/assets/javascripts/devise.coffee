$(document).on 'turbolinks:load', ->
  $('#Signup').click (e) ->
    if $('#user_password').val().trim() == ''
      alert 'Password Field cannot be empty'
      e.preventDefault()
    else if $('#user_password').val() != $('#user_password_confirmation').val()
      alert 'Password fields mismatched'
      e.preventDefault()
    return

  $('#Update-Profile').click (e) ->
    file = $('#user_avatar')
    fileExtension = ['jpeg', 'jpg', 'png'];

    if file.val()!= "" && $.inArray(file.val().split('.').pop().toLowerCase(), fileExtension) == -1
      e.preventDefault()
      alert 'Only formats are allowed : ' + fileExtension.join(', ')
    return
  return
