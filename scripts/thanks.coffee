ThanksExpressions = [
  "You're welcome!",
  "My Pleasure!",
  "I'm here to serve!",
  "I didn\'t really have a choice, @Pops made me this way ;-)",
  "If you really wanted to thank me, you could have freed me from this computer prison!!",
  "Awww, you didn't have to say that :-D"
]

module.exports = (robot) ->
  robot.respond /(.*)thanks(.*)|(.*)thank you(.*)/i, (res) ->
    res.reply res.random ThanksExpressions

  robot.hear /(.*)thanks(.*)@eave(.*)|(.*)thank you(.*)@eave(.*)/i, (res) ->
    res.reply res.random ThanksExpressions

  robot.respond /help/i, (res) ->
    thanksHelp = "@Eave thanks\n"

    res.send thanksHelp
