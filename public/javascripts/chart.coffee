chart = undefined

Highcharts.setOptions
  global: useUTC: false

$(document).ready ->
  chart = new Highcharts.Chart(
    
    chart:
      renderTo: 'container'
      defaultSeriesType: 'spline'
      plotBackgroundImage: 'images/skies.jpg'
      marginRight: 0

      events:
        load: ->
          series = @series[0];
          setInterval (->
            x = new Date().getTime()
            y = Math.random();
            series.addPoint [x, y], true, true
          ), 512

    title:
      text: 'live.js - real-time event visualization'

    xAxis:
      type: 'datetime'
      tickPixelInterval: 168

    yAxis:
      title:
        text: ''
      plotLines: [
        value: 0
        width: 1
        color: 'white'
      ]

    tooltip: false
    legend:
      enabled: false
    exporting:
      enabled: false

    series: [
      data: (->
        data = []
        time = new Date().getTime()
        for i in [-21..0]
          data.push(
            x: time + i * 987,
            y: Math.random()
          )
        data
      )()
    ]
  )
  undefined