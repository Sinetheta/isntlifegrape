`import Ember from 'ember'`

tastingRoute = Ember.Route.extend
  model: ->
    @store.find('tasting')

`export default tastingRoute`
