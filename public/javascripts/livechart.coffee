#
# live.js
# Copyright(c) 2011 Wagner Montalvao Camarao <functioncallback@gmail.com>
# MIT Licensed
#

$ ->

  count = 0
  events = {}
  selected = undefined
  title = $('#title')
  container = $('#container')
  navigation = $('#navigation')
  watchers = $('#watchers')
  width = $(window).width()
  Highcharts.setOptions global: useUTC: false

  now.count = (n) ->
    watchers.text "#{if n > 1 then "#{n} people" else 'you\'re the only one'} watching"

  now.update = (e) ->
    event = events[e.id]
    setup e.id unless event?
    event?.update? e.x, e.y

  setup = (id) ->

    count++
    event = events[id] = {}
    event.container = $('<div>', { id: "container-#{count}", style: 'display: none' })
    event.container.width width
    event.item = $('<div class="item">')
    event.item.text id

    event.item.click ->
      title.fadeOut -> title.text id; title.fadeIn()
      selected.fadeOut -> event.container.fadeIn()
      selected = event.container

    if not selected?
      title.text id
      selected = event.container
      selected.fadeIn()

    container.append event.container
    navigation.append event.item

    event.livechart = new Highcharts.Chart(

      title: (text: '')

      chart:
        renderTo: "container-#{count}"
        defaultSeriesType: 'spline'
        plotBackgroundImage: 'images/skies.jpg'
        marginRight: 0

        events:
          load: ->
            series = @series[0]
            event.update = (x, y) ->
              series.addPoint [x, y], true, true

      xAxis:
        type: 'datetime'
        tickPixelInterval: 150

      yAxis:
        title: (text: '')
        plotLines: [value: 0, width: 1, color: 'white']

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