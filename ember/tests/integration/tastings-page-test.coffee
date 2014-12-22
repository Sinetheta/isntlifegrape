`import startApp from 'isntlifegrape/tests/helpers/start-app'`

App = server = tastings = null

module 'Integration - Tastings Page',
  setup: ->
    App = startApp()
    tastings = [
      (id: 1, title: 'My first tasting')
      (id: 2, title: 'The best tasting ever')
      (id: 3, title: 'I never want to drink again')
    ]
    server = new Pretender ->
      @get '/api/tastings', (request) ->
        [
          200
          'Content-Type': 'application/json'
          JSON.stringify(tastings: tastings)
        ]

      @get '/api/tastings/:id', (request) ->
        tasting = tastings.find (tasting) ->
          tasting if tasting.id is parseInt(request.params.id, 10)
        [
          200
          'Content-Type': 'application/json'
          JSON.stringify(tasting: tasting)
        ]

  teardown: ->
    Ember.run(App, 'destroy')
    server.shutdown()

test 'Should allow navigation to the tastings page from the landing page', ->
  visit('/').then ->
    click('a:contains(\'Tastings\')').then ->
      equal(find('h3').text(), 'Tastings')

test 'Should list all tastings', ->
  visit('/tastings').then ->
    equal(find("a:contains(\'#{tastings[0].title}\')").length, 1)
    equal(find("a:contains(\'#{tastings[1].title}\')").length, 1)
    equal(find("a:contains(\'#{tastings[2].title}\')").length, 1)

test 'Should be able to navigate to a tasting page', ->
  visit('/tastings').then ->
    click("a:contains(\'#{tastings[0].title}\')").then ->
      equal(find('h4').text(), tastings[0].title)

test 'Should be able visit a tasting page', ->
  visit('/tastings/1').then ->
    equal(find('h4').text(), tastings[0].title)
