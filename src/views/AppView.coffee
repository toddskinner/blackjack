class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button"> New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
    #  @model.get('playerHand').stand()
      @model.get('dealerHand').stand()
      @disableButtons()
      return
    'click .new-game-button': ->
      @model.newGame()
      @enableButtons()
      @render()
      return


  initialize: ->
    @render()
    @model.get('dealerHand').on "endGame", @disableButtons, this
    @model.get('playerHand').on "endGame", @disableButtons, this
    setTimeout (->@model.get('playerHand').blackjack()).bind(@), 500
    setTimeout (->@model.get('dealerHand').blackjack()).bind(@), 500
    return

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  disableButtons: ->
    $('.hit-button').prop("disabled", true)
    $('.stand-button').prop("disabled", true)
    return

  enableButtons: ->
    $('.hit-button').prop("disabled", false)
    $('.stand-button').prop("disabled", false)
    return
