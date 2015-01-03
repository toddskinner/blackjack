class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'click: .stand-button', => @disableButtons()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    console.log @collection.isDealer
    if @collection.isDealer
      @$('.score').text @collection.dealerScore()
    else
      @$('.score').text @collection.scores()[0]

    if @collection.busted()
      alert 'BUSTED!'
      @disableButtons()
      return

  disableButtons: ->
    $('.hit-button').prop("disabled", true)
    $('.stand-button').prop("disabled", true)
    return

