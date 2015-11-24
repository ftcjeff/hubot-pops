module.exports = (robot) ->
  getState = (res) ->
    state = res.message.user.id
    woprState = robot.brain.get(state) or {woprState: 0}
    return woprState

  setState = (res, woprState) ->
    state = res.message.user.id
    robot.brain.set(state, woprState)

  robot.hear /help games/i, (res) ->
    res.send "'GAMES' REFERS TO MODELS, SIMULATIONS AND GAMES WHICH HAVE TACTICAL AND STRATEGIC APPLICATIONS."

  robot.hear /list games/i, (res) ->
    res.send "FALKEN'S MAZE\nBLACK JACK\nGIN RUMMY\nHEARTS\nBRIDGE\nCHECKERS\nCHESS\nPOKER\nFIGHTER COMBAT\nGUERRILLA ENGAGEMENT\nDESERT WARFARE\nAIR-TO-GROUND ACTIONS\nTHEATERWIDE TACTICAL WARFARE\nTHEATERWIDE BIOTOXIC AND CHEMICAL WARFARE\n\nGLOBAL THERMONUCLEAR WAR"

    userState = getState(res)
    userState.woprState = 1
    setState(res, userState)

  robot.hear /login joshua/i, (res) ->
    userState = getState(res)
    if userState.woprState != 1
      return

    res.send "GREETINGS PROFESSOR FALKEN."
    res.finish

    userState.woprState = 2
    setState(res, userState)

  robot.hear /hello/i, (res) ->
    userState = getState(res)
    if userState.woprState != 2
      return

    res.send "HOW ARE YOU FEELING TODAY?"
    res.finish

    userState.woprState = 3
    setState(res, userState)

  robot.hear /I'm fine. how are you|I'm fine.  how are you|how are you/i, (res) ->
    userState = getState(res)
    if userState.woprState != 3
      return

    res.send "EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE REMOVAL OF YOUR USER ACCOUNT NUMBER ON 6/23/73?"
    res.finish

    userState.woprState = 4
    setState(res, userState)

  robot.hear /People sometimes make mistak/i, (res) ->
    userState = getState(res)
    if userState.woprState != 4
      return

    res.send "YES THEY DO.  SHALL WE PLAY A GAME?"
    res.finish

    userState.woprState = 5
    setState(res, userState)

  robot.hear /How about Global Thermonuclear War/i, (res) ->
    userState = getState(res)
    if userState.woprState != 5
      return

    res.send "WOULDN'T YOU PREFER A GOOD GAME OF CHESS?"
    res.finish

    userState.woprState = 6
    setState(res, userState)

  robot.hear /Let's play Global Thermonuclear War/i, (res) ->
    userState = getState(res)
    if userState.woprState != 6
      return

    res.send "FINE"
    res.finish

    userState.woprState = 1
    setState(res, userState)

  robot.hear /What is the primary goal/i, (res) ->
    res.send "TO WIN THE GAME."
    res.finish

  robot.hear /is this a game or is it real?/i, (res) ->
    res.send "WHAT'S THE DIFFERENCE?"
    res.finish

  robot.hear /wopr reset/i, (res) ->
    res.reply "Okay, I've reset you back to the beginning"
    res.finish

    userState = getState(res)
    userState.woprState = 1
    setState(res, userState)

  robot.respond /help/i, (res) ->
    res.send "list games\n" +
             "help games\n" +
             "login joshua\n" +
             "what is the primary goal\n" +
             "is this a game or is it real?\n" +
             "wopr reset\n"
