# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class @Game
  constructor: ->
    @startAt = new Date()
    @answers = []

$ ->
  window.game = new Game()
  $('#btn-true,#btn-false').on 'click', ->
    currentChallenge = $(@).parent('.challenge')
    rightAnswer = @value == currentChallenge.attr('result')
    [_class,label] = if rightAnswer then ['right',"√"] else ['wrong',"†"]
    $(".answers").append($("<span class='#{_class}'>#{label}</span>"))
    currentChallenge.hide()
    currentChallenge.next('.challenge').show()


