class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change reset', => @render()
    @collection.on 'click: .stand-button', => @disableButtons()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    if @collection.isDealer
      @$('.score').text @collection.bestScore()
    else
      if @collection.hasAce()
        @$('.score').text @collection.scores()[0] + ' or ' + @collection.scores()[1]
      else
        @$('.score').text @collection.scores()[0]
    if @collection.busted()
      @disableButtons()
    return

  disableButtons: ->
    $('.hit-button').prop("disabled", true)
    $('.stand-button').prop("disabled", true)
    return

