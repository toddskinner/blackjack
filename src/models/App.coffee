# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.log @get('dealerHand').models[0].attributes.value
    console.log @get('dealerHand').models[1].attributes.value
    @get('dealerHand').on "endGame", @gameResult, this
    @get('playerHand').on "endGame", @gameResult, this
    return


  gameResult: ->
    dealerScore = @get('dealerHand').bestScore()
    playerScore = @get('playerHand').bestScore()
    if @get('dealerHand').isBusted
      alert 'Dealer busted. You win!'
    else if @get('playerHand').isBusted
      alert 'Busted. You lose!'
    else if playerScore is dealerScore
      alert 'Draw'
    else if @get('playerHand').isBlackjack
      alert 'BLACKJACK!! You win!!'
    else if @get('dealerHand').isBlackjack
      alert 'Dealer Blackjack...You lose.'
    else if dealerScore > playerScore
      alert 'You Lose'
    else if playerScore > dealerScore
      alert 'You Win'
    return

  newGame: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('dealerHand').on "endGame", @gameResult, this
    @get('playerHand').on "endGame", @gameResult, this
    #@initialize()
    console.log @get 'playerHand'
    return
