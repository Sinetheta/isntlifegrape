`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
  renderTemplate: ->
    @render()
    @render 'navigation',
      into: 'application'
      outlet: 'sidebar'

`export default ApplicationRoute`
