#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$(document).ready ->

  count = 0
  events = {}
  selected = {}
  title = $('#title')
  container = $('#container')
  navigation = $('#navigation')
  Highcharts.setOptions global: useUTC: false

  now.count = (watchers) ->
    console.log "#{watchers} #{if watchers > 1 then 'people' else 'person'} watching"

  now.update = (event) ->
    setup event.id unless events[event.id]?
    events[event.id]?.update? event.x, event.y

  setup = (id) ->

    count++
    livechart = events[id] = {}
    livechart.container = $('<div>', { id: "container-#{count}", style: 'display: none' })
    livechart.container.width $(window).width()
    livechart.item = $('<div class="item">')
    livechart.item.text id

    livechart.item.click ->
      title.fadeOut -> title.text id; title.fadeIn()
      selected.container.fadeOut -> livechart.container.fadeIn()
      selected.container = livechart.container

    if not selected.container?
      title.text id
      selected.container = livechart.container
      selected.container.fadeIn()

    container.append livechart.container
    navigation.append livechart.item

    livechart.view = new Highcharts.Chart(

      title: (text: '')

      chart:
        renderTo: "container-#{count}"
        defaultSeriesType: 'spline'
        plotBackgroundImage: 'images/skies.jpg'
        marginRight: 0

        events:
          load: ->
            series = @series[0]
            livechart.update = (x, y) ->
              series.addPoint [x, y], true, true

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