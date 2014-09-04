# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_query").on("ajax:success", (e, data, status, xhr) ->
    $( "#result_start" ).html( "<b>Los resultados de tu consulta son:</b>" )
    data.results.forEach (result) ->
      average = Number(result.average).toLocaleString() || 'incalculable'
      sum = Number(result.sum).toLocaleString()
      $( "#result_" + result.name ).html( "- El promedio de " + result.human_name + " es " + average + " y la suma es " + sum + " con " + result.count + " registros contabilizados" )
      $( "#result_error" ).html( "" )
  ).on "ajax:error", (e, xhr, status, error) ->
    $( "#result_error" ).html( "<b>ERROR: Posiblemente una o ambas fechas son incorrectas. Por favor, revisar y reintentar.</b>" )
