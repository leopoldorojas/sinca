# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_query").on("ajax:success", (e, data, status, xhr) ->
    data.results.forEach (result) ->
      average = result.average || 'incalculable'
      $( "#result_" + result.name ).html( "El promedio es " + average + " y la suma es " + result.sum + " con " + result.count + " empresas contabilizadas" )
  ).on "ajax:error", (e, xhr, status, error) ->
    $( "#result_error" ).html( "ERROR" )
