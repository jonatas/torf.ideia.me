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
  answer: (value) ->
    rightOrWrong = value == currentChallenge.attr('result')
    @answers.push rightOrWrong
    @answerTime +=  (new Date()).getTime() - @lastAnswer.getTime() if @lastAnswer?
    @lastAnswer = new Date()
    if rightOrWrong is true
      @success += 1
    else
      @fails += 1

    [_class,label] = if rightOrWrong then ['right',"√"] else ['wrong',"†"]

    $(".answers").append($("<span class='#{_class}'>#{label}</span>"))
    @nextChallenge()
    $("#status").html(@status())
  nextChallenge: ->
    currentChallenge.hide()
    nextChallenge = currentChallenge.next('.challenge')
    nextChallenge.show()
    window.currentChallenge = nextChallenge
  status: ->
    """
      #{currentChallenge.attr('sequence')}: 
      <span class='right'>#{@success}√</span> 
      <span class='wrong'>#{@fails}†</span>
      in #{@answerTime / 1000} seconds
    """

$ ->
  window.game = new Game()
  $('#btn-true,#btn-false').on 'click', ->
    window.currentChallenge = $(@).parents('.challenge')
    game.answer @value, currentChallenge

