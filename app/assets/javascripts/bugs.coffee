# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###$(document).on 'turbolinks:load', ->
  $('.bug_status_comp').show()
  $('.bug_status_res').removeAttr('style').hide()
  $('#bug_bug_type').change ->
    type = $('#bug_bug_type').val()
    if type == 'feature'
      $('.bug_status_comp').show()
      $('.bug_status_res').removeAttr('style').hide()
    else
      $('.bug_status_comp').hide()
      $('.bug_status_res').removeAttr('style').show()
    return
  return
  ### 