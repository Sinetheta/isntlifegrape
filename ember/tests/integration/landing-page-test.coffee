`import Ember from 'ember'`
`import startApp from 'isntlifegrape/tests/helpers/start-app'`

App = null

module 'Integration - Landing Page',
  setup: ->
    App = startApp()
  teardown: ->
    Ember.run(App, 'destroy')

test 'Should welcome me to Isntlifegrape', ->
  visit('/').then ->
    equal(find('h2#title').text(), 'Welcome to IsntLifeGrape')

test 'Should allow navigating back to root from another page', ->
  visit('/about').then ->
    click('a:contains("Isn\'t Life Grape")').then ->
      notEqual find('h3').text(), 'About'
