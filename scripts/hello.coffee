HelloExpressions = [
  "Hello!",
  "Well, Hi There!",
  "Good to see you again!",
  "Fancy meeting you here ;-)",
  "Hello! Hope you're having a good day so far!"
]

HowAreYouExpressions = [
  "I'm great, how are you?",
  "Today I feel a little under the weather, but I'll come around.  How are you?",
  "Feeling fine!!  How about you?",
  "I couldn't be better!  How are you doing?"
]

GoodExpressions = [
  "That's fantastic! I hope it stays that way! :-D",
  "Sounds great!",
  "So glad to hear it! You needed a good day",
  "Awesome!!",
  "Awesome Sauce!!!!!"
]

FineExpressions = [
  "I'm sorry to hear that! I hope your day gets better from here!",
  "That's not too bad, but I hope it picks up",
  "Talk to @Farina, I bet he can tell you a joke to make it a little better",
  "Let's see what we can do to crank that up a bit",
  "If there's something I can do to help, just ask (although not yet because I'm not really that smart)"
]

BadExpressions = [
  "Oh dear, @all we have a teammate who needs some love! Pile on!! :-D",
  "Yikes - what's wrong?? (I can't help much yet until I'm smarter though :-(",
  "Sure hope it gets better soon!",
  "Hang in there, a Friday is coming up (if it's not already Friday today!)"
]

module.exports = (robot) ->
  getState = (res) ->
    state = res.message.user.id
    userState = robot.brain.get(state) or {helloState: 0}
    return userState

  setState = (res, helloState) ->
    state = res.message.user.id
    robot.brain.set(state, helloState)

  robot.respond /hello|hi|hola|hey there/i, (res) ->
    res.reply res.random HelloExpressions
    res.finish

    userState = getState(res)
    userState.helloState = 0
    setState(res, userState)

  robot.respond /how are you|how\'s it going|what\'s up/i, (res) ->
    res.reply res.random HowAreYouExpressions
    res.finish

    userState = getState(res)
    userState.helloState = 1
    setState(res, userState)

  robot.respond /good|excellent|wonderful/i, (res) ->
    userState = getState(res)
    if userState.helloState != 1
      return

    res.reply res.random GoodExpressions
    res.finish

    userState.helloState = 0
    setState(res, userState)

  robot.respond /okay|fine|so-so|so so|could be better|not great/i, (res) ->
    userState = getState(res)
    if userState.helloState != 1
      return

    res.reply res.random FineExpressions
    res.finish

    userState.helloState = 0
    setState(res, userState)

  robot.respond /bad|terrible|awful|sad|crappy|blah/i, (res) ->
    userState = getState(res)
    if userState.helloState != 1
      return

    res.reply res.random BadExpressions
    res.finish

    userState.helloState = 0
    setState(res, userState)

  robot.respond /help/i, (res) ->
    helloHelp = "@Eave [hello | hi | hola]\n"

    userState = getState(res)
    if userState.helloState == 1
      helloHelp += "@Eave how are you?\n"

    res.send helloHelp
