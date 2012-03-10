-- | Game time and speed.
module Game.LambdaHack.Time
  ( Time, timeZero, timeTurn, timeStep  -- do not add timeTick!
  , timeAdd, timeFit, timeNegate, timeScale
  , timeToDigit
  , Speed(..), speedNormal, speedTilePerTurn
  , speedScale, ticksPerMeter
  ) where

import Data.Binary
import qualified Data.Char as Char

-- | Game time in ticks. The time dimension.
-- One tick is 1 ms (0.001 s), one turn is 0.05 s, one step is 0.5 s.
-- Moves are resolved and screen frame is generated every turn.
newtype Time = Time Int
  deriving (Show, Eq, Ord)

instance Binary Time where
  put (Time n) = put n
  get = fmap Time get

-- | Start of the game time, or zero lenght time interval.
timeZero :: Time
timeZero = Time 0

-- | The smallest unit of time. It is not exported, because it's
-- an implementation detail. Determines resolution of the time dimension.
-- Currently one tick is 1 ms (0.001 s).
_timeTick :: Time
_timeTick = Time 1

-- | Each turn all moves are resolved and a single screen frame is generated.
-- Currently one turn is 0.05 s, but it may change, though unlikely,
-- and the code should not depend on this absolute value.
timeTurn :: Time
timeTurn = Time 50

-- | One step is 0.5 s. The code may depend on that.
-- Actors at normal speed (2 m/s) take one step to move one tile (1 m by 1 m).
timeStep :: Time
timeStep = Time 500

-- | Time addition.
timeAdd :: Time -> Time -> Time
timeAdd (Time t1) (Time t2) = Time (t1 + t2)

-- | How many time intervals of the second kind fits in an interval
-- of the first kind.
timeFit :: Time -> Time -> Int
timeFit (Time t1) (Time t2) = t1 `div` t2

-- | Negate a time interval. Can be used to subtract from a time
-- or to reverse the ordering on time.
timeNegate :: Time -> Time
timeNegate (Time t) = Time (-t)

-- | Scale time by an integer scalar value.
timeScale :: Time -> Int -> Time
timeScale (Time t) s = Time (t * s)

-- | Represent the main 10 thresholds of a time range by digits,
-- given the total length of the time range.
timeToDigit :: Time -> Time -> Char
timeToDigit (Time maxT) (Time t) =
  let k = 10 * t `div` maxT
      digit | k > 9     = '*'
            | k < 0     = '-'
            | otherwise = Char.intToDigit k
  in digit

-- | Speed in meters per 10 seconds (m/10s).
-- Actors at normal speed (2 m/s) take one time step (0.5 s)
-- to move one tile (1 m by 1 m).
newtype Speed = Speed Int
  deriving (Show, Eq, Ord)

instance Binary Speed where
  put (Speed n) = put n
  get = fmap Speed get

-- | Normal speed (2 m/s) that suffices to move one tile in one step.
speedNormal :: Speed
speedNormal = Speed 20

-- | Speed of one tile per time turn (20 m/s).
speedTilePerTurn :: Speed
speedTilePerTurn = Speed 200

-- | Scale speed by an integer scalar value.
speedScale :: Speed -> Int -> Speed
speedScale (Speed v) s = Speed (v * s)

-- | The number of time ticks it takes to walk 1 meter at the given speed.
ticksPerMeter :: Speed -> Time
ticksPerMeter (Speed v) =
  let Time ticksInStep = timeStep
      stepsInSecond = 2
      secondsIn10s = 10
  in Time $ ticksInStep * stepsInSecond * secondsIn10s `div` v
