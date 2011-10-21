#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

livechart = undefined
Highcharts.setOptions global: useUTC: false
now.count = (watchers) -> console.log "#{watchers} #{if watchers > 1 then 'people' else 'person'} watching"
$(document).mousemove (e) -> $.post '/event', { id: 'live.js' }
$(document).ready ->

  livechart = new Highcharts.Chart(

    title: (text: 'live.js - real-time event visualization')

    chart:
      renderTo: 'container'
      defaultSeriesType: 'spline'
      plotBackgroundImage: 'images/skies.jpg'
      marginRight: 0

      events:
        load: ->
          series = @series[0];
          now.update = (event) ->
            series.addPoint [event.x, event.y], true, true

    xAxis:
      type: 'datetime'
      tickPixelInterval: 150

    yAxis:
      title: (text: '')
      plotLines: [
        value: 0
        width: 1
        color: 'white'
      ]

    tooltip: false
    legend: (enabled: false)
    exporting: (enabled: false)

    series: [
      data: (->
        initial = []
        initial.push(y:0, x:Date.now()+1000*n) for n in [-19..0]
        initial
      )()
    ]
  )
  undefined