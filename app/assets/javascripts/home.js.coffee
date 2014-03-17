#Models
schedule_reservation = (scheduled_at)->
  $.ajax '/reservations',
    type: 'POST'
    dataType: 'json'
    data: { scheduled_at: scheduled_at }
    error: (jqXHR, textStatus, errorThrown) ->
      show_error_message(jqXHR)
    success: (data, textStatus, jqXHR)->
      fill_schedule(scheduled_at, data["name"], data["id"])

list_reservations = ->
  $.ajax '/reservations',
    type: 'GET'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      show_error_message(jqXHR)
    success: (data, textStatus, jqXHR)->
      for schedule in data
        fill_schedule(schedule.scheduled_at, schedule.name, schedule.id)

cancel_reservation = (reservation)->
  reservation_id = $(reservation).data("reservation_id")
  $.ajax "/reservations/#{reservation_id}/cancel",
    type: 'POST'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      show_error_message(jqXHR)
    success: (data, textStatus, jqXHR)->
      remove_cancelation_link(reservation)


#Helpers
fill_schedule = (scheduled_at, name, reservation_id)->
  element = $("[data-datetimerecord='#{scheduled_at}']")
  element.html(name)
  $(element).unbind "click"
  add_cancelation_link(element, reservation_id)

add_cancelation_link = (element, reservation_id)->
  $(element).data("reservation_id", reservation_id)
  $(element).data("old_html", $(element).html())
  $(element).data("hover_html", "click to cancel")
  $(element).hover (->
    $(this).html($(this).data("hover_html"))
    $(this).unbind "click"
    $(this).bind "click.cancelationLink", ->
      cancel_reservation(this)
  ), ->
    $(this).html($(this).data("old_html"))
    add_schedule_reservation_link(this)

remove_cancelation_link = (element) ->
  $(element).html ""
  $(element).data "old_html", ""
  $(element).unbind 'mouseenter mouseleave'
  add_schedule_reservation_link(element)

add_schedule_reservation_link = (element) ->
  $(element).unbind "click.cancelationLink"
  $(element).bind "click", ->
    schedule_reservation($(element).data('datetimerecord'))

show_error_message = (jqXHR)->
  error_messages = jqXHR.responseJSON["error_messages"]
  for key, value of error_messages
    alert("An error ocurred on #{key}, it #{value}")

#Behaviours
$(document).ready ->
  #when the page is loaded
  list_reservations()

  #when an user wants to schedule:
  $("[data-datetimerecord]").each ->
    add_schedule_reservation_link(this)
