$(document).ready ->
  $('#Signup').click (e) ->
    if $('#user_password').val().trim() == ''
      alert 'Password Field cannot be empty'
      e.preventDefault()
    else if $('#user_password').val() != $('#user_password_confirmation').val()
      alert 'Password fields mismatched'
      e.preventDefault()
    return
  return
