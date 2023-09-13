push = require 'lib/push'
Class = require 'lib/class'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/Util'
require 'src.Player'


require 'src/StateMachine'

-- game states
require 'src/States/BaseState'
require 'src.States.Game.TitleState'
require 'src.States.Game.PlayState'
