`import startApp from 'isntlifegrape/tests/helpers/start-app'`

App = null

module 'Integration - About Page',
  setup: ->
    App = startApp()

  teardown: ->
    Ember.run App, 'destroy'

test 'Should navigate to the About page', ->
  visit('/').then ->
    click('a:contains("About")').then ->
      equal find('h3').text(), 'About'
