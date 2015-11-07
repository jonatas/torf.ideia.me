# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class @Game
  constructor: ->
    @startAt = new Date()
    @answers = []
    @success = 0
    @fails = 0
    @answerTime = 0
    @timeout = new AnswerTimeout(10)
    @timeouted = 0
  start: ->
    @currentChallenge = $(".challenge:first")
    @timeout.start()
  answer: (value) ->
    rightOrWrong = value == @currentChallenge.attr('result')
    @answers.push rightOrWrong
    @answerTime +=  (new Date()).getTime() - @lastAnswer.getTime() if @lastAnswer?
    @lastAnswer = new Date()

    @nextChallenge(rightOrWrong)
    @updateStatus()

  updateStatus: -> $("#status").html(@status())
  nextChallenge: (rightOrWrong)->
    @classifyAnswer(rightOrWrong)
    @currentChallenge.hide()
    nextChallenge = @currentChallenge.next('.challenge')
    console.log nextChallenge
    if nextChallenge?
      nextChallenge.show()
      @timeout.cancel()
      @timeout = new AnswerTimeout(5 + @timeout.time)
      @currentChallenge = nextChallenge
      @timeout.start()
    else
      @finishGame()
  status: ->
    """
      #{@currentChallenge.attr('sequence')}: 
      <span class='right'>#{@success}√</span> 
      <span class='wrong'>#{@fails}†</span>
      <span class='timeouted'>#{@timeouted}ø</span>
      ( #{@timeout.time} )
    """
  eachTimeoutSecond: ->
    @updateStatus()
  timeFromStart: -> ((new Date()).getTime() - @startAt.getTime()) / 1000
  onAnswerTimeout: -> @nextChallenge(null)
  finishGame: ->
    @timeout.cancel()
    $(".challenge").hide()
    $(".buttons").hide()
    failChallenges = $(".challenge[answer=wrong]")
    if failChallenges.length > 0
      $("#status").text("Review your #{failChallenges.length} fails")
      failChallenges.show()
      for challenge in failChallenges
        challenge = $(challenge)
        challenge.find('.code pre').append("<span class='timeouted'> # => #{challenge.attr('result')}</span>")
    else
      $("#status").text("You are a true compiler! Congratulations!")
  classifyAnswer: (rightOrWrong) ->
    if rightOrWrong is null
      @timeouted += 1
      [_class, label] = ['timeouted',"ø"]
    else if rightOrWrong is true
      @success += 1
      [_class,label] = ['right',"√"]
    else
      @fails += 1
      [_class, label] = ['wrong',"†"] 

    @currentChallenge.attr('answer', _class)
    $(".answers").append($("<span class='#{_class}'>#{label}</span>"))

class AnswerTimeout
  constructor: (@time=10) ->
  cancel: ->
    @canceled = true
    clearTimeout(@timeoutId)
  start: ->
    @time -= 1
    countdown = (i) ->
      game.timeout.time = i
      if i < 0
        game.onAnswerTimeout()
      else
        game.timeout.timeoutId = setTimeout(countdown.bind(@), 1000, i - 1) if !@canceled?
      game.eachTimeoutSecond(i)
    game.timeout.timeoutId =  countdown.bind(@)(@time)
$ ->
  window.game = new Game()
  game.start()
  $('#btn-true,#btn-false').on 'click', ->
    game.answer @value
