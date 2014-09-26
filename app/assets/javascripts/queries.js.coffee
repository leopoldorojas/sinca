# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

dataset = [ 25, 7, 5, 26, 11, 8, 25, 14, 23, 19,
                14, 11, 22, 29, 11, 13, 12, 17, 18, 10,
                24, 18, 25, 9, 3 ]

d3.select("#graphs").selectAll("div.bar")
    .data(dataset)
    .enter()
    .append("div")
    .attr("class", "bar")
    .style("height", (d) ->
      barHeight = d * 5
      barHeight + "px"
    )