assert = chai.assert

describe 'app', ->
  deck = null
  hand = null


  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
#    dealerHand = new Hand(ace, king)

  describe 'blackjack', ->
    it 'should alert "blackjack" for the player', ->
      ace = new Card("rank": 1, "suit": 1)
      king = new Card("rank": 13, "suit": 25)
      playerHand = new Hand [ace, king]
      playerHand.blackjack()
      assert.strictEqual playerHand.isBlackjack, true

    it 'should alert "blackjack" for the dealer', ->
      ace = new Card("rank": 1, "suit": 1)
      ace.set 'revealed', false
      king = new Card("rank": 13, "suit": 25)
      dealerHand = new Hand [ace, king]
      dealerHand.blackjack()
      assert.strictEqual dealerHand.isBlackjack, true
