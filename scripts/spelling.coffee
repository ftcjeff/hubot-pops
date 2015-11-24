module.exports = (robot) ->
  robot.hear /yo'ure|your'e/i, (res) ->
    res.reply "Whoops, looks like you misspelled that. It's: you're"

  robot.hear /your welcome/i, (res) ->
    res.reply "Whoops, looks like your grammar needs work. It's: you're welcome"

  robot.hear /adn/i, (res) ->
    res.reply "Whoops, looks like you misspelled that. It's: and"

  robot.hear /strat/i, (res) ->
    res.reply "Whoops, looks like you might have misspelled that. I believe it's: start"

  robot.hear /teh/, (res) ->
    res.reply "Uh-oh, looks like you might have misspelled that. I believe it's: the"
