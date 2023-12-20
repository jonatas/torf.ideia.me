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
    @timeouted = 0
  setup: ->
    $(".setup").show()
    $("#torf_buttons").hide()
    $("#btn-ok").show()

  ack: ->
    # minimize the setup code examples reduzing font size of the entire pre
    # and removing the line numbers. Also reduce the padding between lines and
    # code elements.
    $(".setup pre").css('line-height', '1.0')
    $(".setup pre").css('display', 'contents')
    $(".setup pre").css('padding', '0px')
    $(".setup pre").css('margin-left', '20px')
    $(".setup pre").css('font-size', '10px')
    $(".setup pre").css('margin-top', '0px')
    $(".setup pre").css('margin-bottom', '0px')
    $("#btn-ok").hide()
    game.start()
  start: ->
    @timeout = new AnswerTimeout(1000)
    @currentChallenge = $(".challenge:first")
    @currentChallenge.show()
    $("#torf_buttons").show()
    @timeout.start()
  answer: (user_input) ->
    rightOrWrong = user_input == @currentChallenge.attr('answer')
    @answers.push rightOrWrong
    @answerTime +=  (new Date()).getTime() - @lastAnswer.getTime() if @lastAnswer?
    @lastAnswer = new Date()
    @nextChallenge(rightOrWrong)
    @updateStatus()
  updateStatus: ->
    $("#answer-number").text(@currentChallenge.attr('sequence'))
    $("#timeout").text( @timeout.time )
    $("#status").html(@status())
  nextChallenge: (rightOrWrong ) ->
    @classifyAnswer(rightOrWrong)
    @currentChallenge.hide()
    nextChallenge = @currentChallenge.next('.challenge')
    if nextChallenge? && nextChallenge.length > 0
      nextChallenge.show()
      @timeout.cancel()
      @timeout = new AnswerTimeout(100 + @timeout.time)
      @currentChallenge = nextChallenge
      @timeout.start()
    else
      @finishGame()
  status: ->
    """
      <span class='badge'> ✅ #{@success}</span> 
      <span class='badge'> ❌ #{@fails}</span>
      <span class='badge'> ⌛️ #{@timeouted}</span>
    """
  eachTimeoutSecond: ->
    @updateStatus()
  timeFromStart: -> ((new Date()).getTime() - @startAt.getTime()) / 1000
  onAnswerTimeout: -> @nextChallenge(null)
  finishGame: ->
    @timeout.cancel()
    $(".challenge").hide()
    $(".buttons").hide()
    failChallenges = $(".challenge[user_answer=wrong]")
    if failChallenges.length > 0
      msg = "<h1>Review your #{failChallenges.length} fails</h1>"
      failChallenges.show()
      for challenge in failChallenges
        challenge = $(challenge)
        challenge.find('.code pre').append("<span class='timeouted'> # => #{challenge.attr('answer')}</span>")
        challenge.find('.hint').show()
    else
      language = $("#challenge").attr('language')
      msg = "You are a true #{language} compiler! Congratulations!"
    $(".challenge:first").before($(msg))
    @sendScore()
  sendScore: ->
    $.ajax(
      url: "/scores.json",
      type: "POST",
      data: score:
        challenge_id: $("#challenge").val()
        right: @success
        wrong: @fails
        timed_out: @timeouted
    )
  classifyAnswer: (rightOrWrong) ->
    if rightOrWrong is null
      @timeouted += 1
      _class= 'timeouted glyphicon glyphicon-time'
    else if rightOrWrong is true
      @success += 1
      _class= 'right glyphicon glyphicon-ok'
    else
      @fails += 1
      _class= 'wrong glyphicon glyphicon-remove'

    @currentChallenge.attr('user_answer', _class.split(' ')[0])
    $(".answers").append($("<span class='#{_class}'></span>"))

class AnswerTimeout
  constructor: (@time=10) ->
  cancel: ->
    @canceled = true
    clearTimeout(@timeoutId)
  start: ->
    @time -= 1
    countdown = (i) ->
      game.timeout.time = i
      game.currentChallenge.find('.hint').show() if game.timeout.time < 3
      if i < 0
        game.onAnswerTimeout()
      else
        game.timeout.timeoutId = setTimeout(countdown.bind(@), 1000, i - 1) if !@canceled?

      game.eachTimeoutSecond(i)
    game.timeout.timeoutId =  countdown.bind(@)(@time)

$ ->
  if $(".challenge").length > 0
    window.game = new Game()
    game.setup()

    $('#btn-ok').on 'touchend click', (event) ->
      event.stopPropagation()
      event.preventDefault()
      game.ack()
    $('#btn-true,#btn-false').on 'touchend click', (event) ->
      event.stopPropagation()
      event.preventDefault()
      game.answer @value

