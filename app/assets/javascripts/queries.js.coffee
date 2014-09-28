# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

graph_width = 480
graph_height = 250
size = "graph_mini"

set_display_events = (indicator, type) -> 
  $( "##{type}_graph_mini_#{indicator}" ).click () ->
    $(".graph_mini").slideUp("slow")
    $("##{type}_graph_detail_#{indicator}").slideDown("slow")
    $("#text_#{indicator}").slideDown("slow")

  $( "##{type}_graph_detail_#{indicator}" ).click () ->
    $(".graph_mini").slideDown("slow")
    $("##{type}_graph_detail_#{indicator}").slideUp("slow")
    $("#text_#{indicator}").slideUp("slow")

create_bar_graph = (indicator) ->
  margin = {top: 20, right: 20, bottom: 30, left: 60}
  width = graph_width - margin.left - margin.right
  height = graph_height - margin.top - margin.bottom

  x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1)

  y = d3.scale.linear()
    .range([height, 0])

  xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")

  yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(10)

  svg = d3.select("#bar_graphs").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .attr("id", "bar_#{size}_#{indicator.indicator}")
    .attr("class", "#{size}")
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  dataset = ([ each_date.date.substr(0,10), each_date.result.average || 0 ] for each_date in indicator.results)

  x.domain(d[0] for d in dataset)
  y.domain([0, d3.max(dataset, (d) -> d[1] )])

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)

  svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Promedio")

  svg.selectAll(".bar")
    .data(dataset)
    .enter().append("rect")
    .attr("class", "bar")
    .attr("x", (d) -> x d[0] )
    .attr("width", x.rangeBand())
    .attr("y", (d) -> y d[1] )
    .attr("height", (d) -> (height - y d[1]) )
  
  set_display_events indicator.indicator, "bar"

create_line_graph = (indicator) ->
  margin = {top: 20, right: 20, bottom: 30, left: 60}
  width = graph_width - margin.left - margin.right
  height = graph_height - margin.top - margin.bottom

  parseDate = d3.time.format("%Y-%m-%d").parse

  x = d3.time.scale()
    .range([0, width])

  y = d3.scale.linear()
    .range([height, 0])

  xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")

  yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")

  line = d3.svg.line()
    .x( (d) -> x(d[0]) )
    .y( (d) -> y(d[1]) )

  svg = d3.select("#line_graphs").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .attr("id", "line_#{size}_#{indicator.indicator}")
    .attr("class", "#{size}")
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  dataset = ([ parseDate(each_date.date.substr(0,10)), each_date.result.average || 0 ] for each_date in indicator.results)

  x.domain d3.extent(dataset, (d) -> d[0])
  y.domain d3.extent(dataset, (d) -> d[1])

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)

  svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Promedio")

  svg.append("path")
    .datum(dataset)
    .attr("class", "line")
    .attr("d", line)

  set_display_events indicator.indicator, "line"

if $('#bar_graphs').length > 0
  indicators = $('#bar_graphs').data('results')
  create_bar_graph indicator for indicator in indicators
  graph_width = 960
  graph_height = 500
  size = "graph_detail"
  create_bar_graph indicator for indicator in indicators
  $(".graph_detail").hide()
else if $('#line_graphs').length > 0
  indicators = $('#line_graphs').data('results')
  create_line_graph indicator for indicator in indicators
  graph_width = 960
  graph_height = 500
  size = "graph_detail"
  create_line_graph indicator for indicator in indicators
  $(".graph_detail").hide()
