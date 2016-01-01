# Based on this tutorial: http://callmenick.com/post/css-transitions-transforms-animations-flipping-card

clickListener = (card) ->
	card.addEventListener "click", (e) ->
    card = this.classList
    if card.contains("flipped") == true
      card.remove("flipped")
    else
      card.add("flipped")

cardFlip = ->
  cards = document.querySelectorAll(".card.effect__click")
  clickListener card for card in cards

$ ->
	$(document).ready(cardFlip)
	$(document).on('page:load', cardFlip)
