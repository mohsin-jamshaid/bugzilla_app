# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#bug_bug_type').change ->
    type = undefined
    type = $('#bug_bug_type').val()
    if type == 'feature'
      selectValues =
        'initial': 'Initial'
        'started': 'Started'
        'completed': 'Completed'
      $('#bug_bug_status').empty()
      $.each selectValues, (key, value) ->
        $('#bug_bug_status').append $('<option></option>').attr('value', key).text(value)
        return
    else if type == 'bug'
      selectValues =
        'initial': 'Initial'
        'started': 'Started'
        'resolved': 'Resolved'
      $('#bug_bug_status').empty()
      $.each selectValues, (key, value) ->
        $('#bug_bug_status').append $('<option></option>').attr('value', key).text(value)
        return
    return
  return
