`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend(location: config.locationType)

Router.map ->
  @route    'about'
  @resource 'tastings', ->
    @route    'show', {path: ':tasting_id'}

`export default Router`
