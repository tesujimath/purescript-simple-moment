-- | A simple PureScript wrapper around moment.js
module Data.Moment.Simple
  ( fromDate
  , fromEpoch
  , calendar
  , module Data.Moment.Simple.Types
  ) where

import Prelude

import Control.MonadPlus (guard)
import Data.Date (toJSDate, Date(), Now())
import Data.Date.Locale (Locale())
import Data.Time (Milliseconds(..))
import Data.Maybe (Maybe())
import Control.Monad.Eff (Eff())

import Data.Moment.Simple.Internal (isValid)
import Data.Moment.Simple.Types (Moment())

-- | Life a valid date into a Moment object.
foreign import fromDate :: Date -> Moment

-- | Turn a Moment date into a human-readable string, e.g. "Today, 9:30pm"
foreign import calendar :: forall eff. Moment -> Eff (now :: Now, locale :: Locale | eff) String

foreign import fromEpoch_ :: Number -> Moment

-- | Construct a Moment object from the milliseconds since
--   1970-01-01 00:00:00.000. If the timestamp is invalid, Nothing is returned.
fromEpoch :: Milliseconds -> Maybe Moment
fromEpoch (Milliseconds i) = do
  let m = fromEpoch_ i
  guard $ isValid m
  return m