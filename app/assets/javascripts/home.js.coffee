#Models
schedule_reservation = (scheduled_at)->
  $.ajax '/reservations',
    type: 'POST'
    dataType: 'json'
    data: { scheduled_at: scheduled_at }
    error: (jqXHR, textStatus, errorThrown) ->
      show_error_message(jqXHR)
    success: (data, textStatus, jqXHR)->
      fill_schedule(scheduled_at, data["name"])

list_reservations = ->
  $.ajax '/reservations',
    type: 'GET'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      show_error_message(jqXHR)
    success: (data, textStatus, jqXHR)->
      console.log(data)
      for schedule in data
        fill_schedule(schedule["scheduled_at"], schedule["name"])

#Helpers
fill_schedule = (scheduled_at, name)->
  $("[data-datetimerecord='#{scheduled_at}']").html(name)

show_error_message = (jqXHR)->
  error_messages = jqXHR.responseJSON["error_messages"]
  for key, value of error_messages
    alert("An error ocurred on #{key}, it #{value}")

#Behaviours
$(document).ready ->
  #when the page is loaded
  list_reservations()

  #when an user wants to schedule:
  $("[data-datetimerecord]").click ->
    schedule_reservation($(this).data('datetimerecord'))
