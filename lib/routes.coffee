module.exports = inject: (app) ->

  app.get '/', (req, res) -> res.render 'index'

  app