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
  answer: (rightOrWrong) ->
    @answers.push rightOrWrong
    @answerTime +=  (new Date()).getTime() - @lastAnswer.getTime() if @lastAnswer?
    @lastAnswer = new Date()
    if rightOrWrong is true
      @success += 1
    else
      @fails += 1


$ ->
  window.game = new Game()
  $('#btn-true,#btn-false').on 'click', ->
    currentChallenge = $(@).parents('.challenge')
    rightAnswer = @value == currentChallenge.attr('result')
    [_class,label] = if rightAnswer then ['right',"√"] else ['wrong',"†"]
    game.answer rightAnswer
    $(".answers").append($("<span class='#{_class}'>#{label}</span>"))
    currentChallenge.hide()
    nextChallenge = currentChallenge.next('.challenge')
    nextChallenge.show()
    status = """
      #{nextChallenge.attr('sequence')}: 
      <span class='right'>#{game.success}√</span> 
      <span class='wrong'>#{game.fails}†</span>
      in #{game.answerTime / 1000} seconds
    """
    $("#status").html(status)

