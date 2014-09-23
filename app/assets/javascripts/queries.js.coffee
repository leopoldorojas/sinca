# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_query").on("ajax:success", (e, data, status, xhr) ->
    $( "#result_start" ).html( "<b>Los resultados de tu consulta son:</b>" )
    Object.keys(data.result_matrix).forEach (date) ->
      Object.keys(data.result_matrix[date]).forEach (result) ->
	      average = Number(data.result_matrix[date][result].average).toLocaleString() || 'incalculable'
	      sum = Number(data.result_matrix[date][result].sum).toLocaleString()
	      $( "#result_" + result ).html( "- El promedio de " + result + " es " + average + " y la suma es " + sum + " con " + data.result_matrix[date][result].count + " registros contabilizados" )
	      $( "#result_error" ).html( "" )
  ).on "ajax:error", (e, xhr, status, error) ->
    $( "#result_error" ).html( "<b>ERROR: Posiblemente una o ambas fechas son incorrectas. Por favor, revisar y reintentar.</b>" )
