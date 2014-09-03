# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_query").on("ajax:success", (e, data, status, xhr) ->
    result = data.results[0]
    average = result.average || 'incalculable'
    $( "#results" ).html( "El promedio es " + average + " y la suma es " + result.sum + " con " + result.count + " empresas contabilizadas" )
    result = data.results[1]
    average = result.average || 'incalculable'
    $( "#results2" ).html( "El promedio es " + average + " y la suma es " + result.sum + " con " + result.count + " empresas contabilizadas" )
    result = data.results[2]
    average = result.average || 'incalculable'
    $( "#results3" ).html( "El promedio es " + average + " y la suma es " + result.sum + " con " + result.count + " empresas contabilizadas" )
  ).on "ajax:error", (e, xhr, status, error) ->
    $( "#results" ).html( "ERROR" )
