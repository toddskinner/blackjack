class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  stand: ->
    # uncover hidden dealer card
    if @isDealer
      @at(0).flip()
      # check dealer score
     # if @hasAce()
      #  highScore = scores()[1]
      @hit() while @dealerScore() < 17
    return

  dealerScore: ->
    # if hasAce
    # then check each of scores array if either (scores[1] >= 17 && scores[1] <= 21) || (scores[0]>=17)
    # if it is, then stop
    if @hasAce()
      if @scores()[1] >= 17 && @scores()[1] <= 21
        return @scores()[1]
    return @minScore()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  busted: -> if @minScore() > 21 then true else false


