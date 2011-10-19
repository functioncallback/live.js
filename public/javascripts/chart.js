(function() {
  var chart;
  chart = void 0;
  Highcharts.setOptions({
    global: {
      useUTC: false
    }
  });
  $(document).ready(function() {
    chart = new Highcharts.Chart({
      chart: {
        renderTo: 'container',
        defaultSeriesType: 'spline',
        plotBackgroundImage: 'images/skies.jpg',
        marginRight: 0,
        events: {
          load: function() {
            var series;
            series = this.series[0];
            return setInterval((function() {
              var x, y;
              x = new Date().getTime();
              y = Math.random();
              return series.addPoint([x, y], true, true);
            }), 512);
          }
        }
      },
      title: {
        text: 'live.js - real-time event visualization'
      },
      xAxis: {
        type: 'datetime',
        tickPixelInterval: 168
      },
      yAxis: {
        title: {
          text: ''
        },
        plotLines: [
          {
            value: 0,
            width: 1,
            color: 'white'
          }
        ]
      },
      tooltip: false,
      legend: {
        enabled: false
      },
      exporting: {
        enabled: false
      },
      series: [
        {
          data: (function() {
            var data, i, time;
            data = [];
            time = new Date().getTime();
            for (i = -21; i <= 0; i++) {
              data.push({
                x: time + i * 987,
                y: Math.random()
              });
            }
            return data;
          })()
        }
      ]
    });
    return;
  });
}).call(this);
