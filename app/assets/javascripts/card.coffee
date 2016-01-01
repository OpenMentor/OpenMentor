# Based on this tutorial: http://callmenick.com/post/css-transitions-transforms-animations-flipping-card
clickListener = (card) ->
	card.addEventListener "click", (e) ->
    cardClassList = $(this).closest('.effect__click')[0].classList
    if cardClassList.contains("flipped") == true
      cardClassList.remove("flipped")
    else
      cardClassList.add("flipped")

cardFlip = ->
  cards = $(".social-links")
  clickListener card for card in cards

$ ->
	$(document).ready(cardFlip)
	$(document).on('page:load', cardFlip)
