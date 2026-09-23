# Kucoin API

This is an unofficial Ruby wrapper for the Kucoin exchange REST and WebSocket APIs.

##### Notice

* This is Alpha software.  All issues should be aggressively reported for quick resolution!
* RESTful interface is fully implemented.
* Websocket is fully implemented.
* Pull Requests are very welcome!
* RSPEC tests depend on Ruby >= 2.4 features, specifically `#match?`  The gem itself should work find with any Ruby 2.x and higher and perhaps 1.9.x, but has certainly not been tested. YMMV!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kucoin-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kucoin-api

## Features

#### Current

* Basic implementation of REST API
  * Easy to use authentication
  * Methods return parsed JSON
  * No need to generate timestamps
  * No need to generate signatures

* Basic implementation of WebSocket API
  * Pass procs or lambdas to event handlers
  * Single streams supported
  * Runs on EventMachine

* Exception handling with responses
* High level abstraction

#### TODO

* Websockets currently uses the first InstanceServer returned in the "Apply connect token" RESTful calls. It is currently not clear what Kucoin intends with multiple InstanceServers, so until a use-case arises or feature/bug request comes along that sheds some light on how to select and use specific servers, the websocket interface is hard-wired to the first instance server returned.

## Getting Started

#### REST Client

Require Kucoin API:

```ruby
require 'kucoin/api'
```

Create a new instance of the REST Client:

```ruby
# If you only plan on touching public API endpoints, you can forgo any arguments
client = Kucoin::Api::REST.new

# Otherwise provide an api_key as keyword arguments
client = Kucoin::Api::REST.new \
  api_key: 'your.api_key', 
  api_secret: 'your.api_secret', 
  api_passphrase: 'your.api_passphrase'

# You can provide a sandbox as argument to change into Sandbox environment 
client = Kucoin::Api::REST.new sandbox: true 
```

|**Environment**        |**BaseUri**                            |
|:---------------------:|:-------------------------------------:|
| Production `DEFAULT`  | https://api.kucoin.com                |
| Sandbox               | https://openapi-sandbox.kucoin.com    |

ALTERNATIVELY, set your API key in exported environment variable:

```bash
export KUCOIN_API_KEY=your.api_key
export KUCOIN_API_SECRET=your.api_secret
export KUCOIN_API_PASSPHRASE=your.api_passphrase
```

Then you can instantiate client without parameters as in first variation above.

Create various requests:

```ruby
# Others / Time / Server Time
client.other.timestamp
  # => 1554213599244

# Currencies Plugin / List exchange rate of coins
client.currency.all
  # => {"rates"=>{"TRAC"=>{"CHF"=>0.02, "HRK"=>0.14...}}

# Public Market Data / Tick
client.market.tick(symbol: 'KCS-BTC')
  # => {"coinType"=>"KCS", "trading"=>true, "symbol"=>"KCS-BTC", "lastDealPrice"=>0.00016493,
  #     "buy"=>0.00016493, "sell"=>0.00016697, "change"=>2.41e-06, "coinTypePair"=>"BTC", "sort"=>0,
  #     "feeRate"=>0.001, "volValue"=>19.92555026, "high"=>0.00016888, "datetime"=>1546427934000,
  #     "vol"=>120465.9024, "low"=>0.000161, "changeRate"=>0.0148
  #   }


# Trading / Create an order
client.order.create 'KCS-BTC', type: 'BUY', price: 0.000127, amount: 22
  # => { "orderOid": "596186ad07015679730ffa02" }


# Assets Operation / Get coin deposit address
client.account.wallet_address('KCS')
  # => {
  #       "oid": "598aeb627da3355fa3e851ca",
  #       "address": "598aeb627da3355fa3e851ca",
  #       "context": null,
  #       "userOid": "5969ddc96732d54312eb960e",
  #       "coinType": "KCS",
  #       "createdAt": 1502276446000,
  #       "deletedAt": null,
  #       "updatedAt": 1502276446000,
  #       "lastReceivedAt": 1502276446000
  #     }
```

Required and optional parameters, as well as enum values, can currently be found on the [Kucoin Apiary Page](https://docs.kucoin.com). Parameters should always be passed to client methods as keyword arguments in snake_case form.  symbol, when a required parameter is simply passed as first parameter for most API calls.

### REST Endpoints

REST endpoints are in order as documented on the Kucoin Apiary page (linked above). 
Endpoints are accessible by following resourceful structure given in Kucoin API documentation. For example - `user.accounts` is for endpoints given in Kucoin API documentation under "User/Accounts". 
The following lists only the method names, aliases (if any) and parameters of the methods to access endpoints. 
For the most part, method names follow RESTful action names and alias method follows the title/name given in Kucoin API documentation. 
There were some deviations where there would otherwise be name clashes/overloading.

#### User

##### Accounts
----

```ruby
# List Accounts
user.accounts.list options={}
```
* required params: none

----
```ruby
# Get an Account
user.accounts.get account_id
```
* required params: account_id

----
```ruby
# Create an Account
user.accounts.create currency, type
```
* required params: currency, type

----
```ruby
# Get Account Ledgers
user.accounts.ledgers account_id, options={}
```
* required params: account_id

----
```ruby
# Get Holds
user.accounts.holds account_id
```
* required params: account_id

----
```ruby
# Inner Transfer
user.accounts.inner_transfer client_oid, currency, from, to, amount, options = {}
```
* required params: client_oid, currency, from, to, amount
* KuCoin lists this endpoint as abandoned. Use `flex_transfer`.

----
```ruby
# Flex Transfer
user.accounts.flex_transfer client_oid, type, currency, amount, from_account_type, to_account_type, options = {}
```
* required params: client_oid, type, currency, amount, from_account_type, to_account_type
* `type` must be one of `INTERNAL`, `PARENT_TO_SUB`, `SUB_TO_PARENT`, `SUB_TO_SUB`
* Pass `fromUserId` or `toUserId` in `options` for master and sub-account transfers.

##### Deposits
----

```ruby
# Create Deposit Address
user.deposits.create currency
```
* required params: currency
* KuCoin lists this endpoint as abandoned. Use `create_v3`.

----
```ruby
# Create Deposit Address (V3)
user.deposits.create_v3 currency, chain, options = {}
```
* required params: currency, chain
* optional: `to` (`main` or `trade`)

----
```ruby
# Get Deposit Address
user.deposits.get currency
```
* required params: currency
* KuCoin lists this endpoint as abandoned. Use `show_v3`.

----
```ruby
# Get Deposit Address (V3)
user.deposits.show_v3 currency, options = {}
```
* required params: currency
* optional: `chain`

----
```ruby
# Get Deposit List
user.deposits.list options={}
```
* required params: none

##### Withdrawals
----

```ruby
# Get Withdrawals List
user.withdrawals.list options={}
```
* required params: none

----
```ruby
# Get Withdrawal Quotas
user.withdrawals.quotas currency
```
* required params: currency

----
```ruby
# Apply Withdraw
user.withdrawals.apply currency, address, amount, options={}
```
* required params: currency, address, amount
* KuCoin lists this endpoint as abandoned. Use `create_v3`.

----
```ruby
# Apply Withdraw (V3)
user.withdrawals.create_v3 currency, to_address, amount, chain, options = {}
```
* required params: currency, to_address, amount, chain
* `withdrawType` defaults to `ADDRESS`

----
```ruby
# Get Withdrawal By ID
user.withdrawals.show withdrawal_id
```
* required params: withdrawal_id

----
```ruby
# Cancel Withdrawal
user.withdrawals.cancel withdrawal_id
```
* required params: withdrawal_id

#### Trade

##### Orders
----

```ruby
# Place a new order
trade.orders.place client_oid, side, symbol, options={}
```
* required params: client_oid, side, symbol

----
```ruby
# Cancel an order
trade.orders.cancel order_id
```
* required params: order_id

----
```ruby
# Cancel all orders
trade.orders.cancel_all options={}
```
* required params: none

----
```ruby
# List Orders
trade.orders.list options={}
```
* required params: none

----
```ruby
# Recent Orders
trade.orders.recent
```
* required params: none

----
```ruby
# Get an order
trade.orders.get order_id
```
* required params: order_id
* KuCoin lists place, cancel, list, recent, and get as abandoned. Use the `hf_` methods.

----
```ruby
# Place a high-frequency order
trade.orders.hf_place symbol, side, type, options = {}
```
* required params: symbol, side, type
* `type` must be `limit` or `market`

----
```ruby
# Open high-frequency orders
trade.orders.hf_active symbol, options = {}
```
* required params: symbol

----
```ruby
# Closed high-frequency orders
trade.orders.hf_closed symbol, options = {}
```
* required params: symbol

----
```ruby
# Get a high-frequency order
trade.orders.hf_show order_id, symbol
```
* required params: order_id, symbol

----
```ruby
# Cancel a high-frequency order
trade.orders.hf_cancel order_id, symbol
```
* required params: order_id, symbol

##### Fills
----

```ruby
# List Fills
trade.fills.list
```
* required params: none

----
```ruby
# Recent Fills
trade.fills.recent
```
* required params: none
* KuCoin lists list and recent as abandoned. Use `hf_index`.

----
```ruby
# High-frequency fills
trade.fills.hf_index symbol, options = {}
```
* required params: symbol

##### Margin
----

```ruby
# Isolated margin accounts
trade.margin.isolated_accounts options = {}
```
* `isolated_account` calls a disabled endpoint. Pass `symbol` and `queryType` here.
* `user.funding.isolated` calls the same URL.

#### Market Data

##### Symbols & Ticker
----

```ruby
# Get Symbols List
markets.all
```
* required params: none

----
```ruby
# Get Ticker
markets.stats symbol
```
* required params: symbol

----
```ruby
# Get All Tickers
markets.tickers.all
```
* required params: none

----
```ruby
# Get 24hr Stats
markets.tickers.inside symbol
```
* required params: symbol

----
```ruby
# Get Market List
markets.symbols.all options={}
```
* required params: none

##### Order Book
----

```ruby
# Get Part Order Book(aggregated)
markets.order_book.part symbol, depth
```
* required params: symbol, depth(20, 100)

----
```ruby
# Get Full Order Book(aggregated)
markets.order_book.full_aggregated symbol
```
* required params: symbol

----
```ruby
# Get Full Order Book(atomic)
markets.order_book.full_atomic symbol
```
* required params: symbol

##### Histories
----

```ruby
# Get Trade Histories
markets.histories.trade symbol
```
* required params: symbol

----
```ruby
# Get Klines
markets.histories.klines symbol, type, options={}
```
* required params: symbol, type

##### Currencies
----

```ruby
# Get Currencies
markets.currencies.all
```
* required params: none

----
```ruby
# Get Currency Detail
markets.currencies.detail currency
```
* required params: currency

----
```ruby
# Get Fiat Price
markets.currencies.fiat options= {}
```
* required params: none

#### Other

##### Time
----

```ruby
# Server Time
other.timestamp
```
* required params: none

## WebSocket Client

Create a new instance of the WebSocket Client:

```ruby
# If you only plan on touching public topics 
client = Kucoin::Api::Websocket.new

# Changing the rest_client argument for different authentication
client = Kucoin::Api::Websocket.new rest_client: Kucoin::Api::REST.new(sendbox: true) 
```

Subscribe various topics:

```ruby
# Public Channels / Symbol Ticker
methods = { message: proc { |event| puts event.data } }
client.ticker symbols: 'ETH-BTC', methods: methods
  # => {"id":"259173795477643264","type":"ack"}
  # => {"data":{"sequence":...}, "subject":"trade.ticker","topic":"/market/ticker:ETH-BTC","type":"message"}
  # => {"data":{"sequence":...}, "subject":"trade.ticker","topic":"/market/ticker:ETH-BTC","type":"message"}
  # => ...
  
# Private Channels / Stop order received event
client.stop_order_received_event symbols: 'BTC-USDT', methods: methods
  # => {"id":"259173795477643264","type":"ack"}
  # => {"data":{"sequence":...}, "subject":"trade.l3received","topic":"/market/level3:BTC-USDT","type":"message"}
  # => {"data":{"sequence":...}, "subject":"trade.l3received","topic":"/market/level3:BTC-USDT","type":"message"}
  # => ...
```

Multiplex:

```ruby
channel = nil
message = proc do |event|
  puts event.data
  data = JSON.parse(event.data)
  if data['type'] == 'ack' && data['id'] == '1222'
    Kucoin::Api::Websocket.subscribe(channel: channel, params: { topic: "/market/ticker:ETH-BTC", tunnelId: 'bt1' })
  end
end
methods = { message: message }
channel = client.multiplex stream: { newTunnelId: 'bt1', id: '1222' }, methods: methods
  # => {"id":"1222","type":"ack"}
  # => {"tunnelId":"bt1","id":"170022900","type":"ack"}
  # => {"data":{"sequence":...},"subject":"trade.ticker","tunnelId":"bt1","topic":"/market/ticker:ETH-BTC","type":"message"}
  # => {"data":{"sequence":...},"subject":"trade.ticker","tunnelId":"bt1","topic":"/market/ticker:ETH-BTC","type":"message"}
  
# Using the one physical connection - `channel`,
# you could open different multiplex tunnels to subscribe different topics for different data.   
```

All subscription topic method will expect "methods" in argument(As shown above).
It's The Hash which contains the event handler methods to pass to the WebSocket client methods.
Proc is the expected value of each event handler key. Following are list of expected event handler keys.
  - :open    - The Proc called when a stream is opened (optional)
  - :message - The Proc called when a stream receives a message
  - :error   - The Proc called when a stream receives an error (optional)
  - :close   - The Proc called when a stream is closed (optional)

### Websocket Feed

Subscribe topics are in order as documented on the Kucoin Apiary page (linked above).

#### Public Channels
----

```ruby
# Symbol Ticker
ticker symbols:, methods:
```
* required params: symbols(Array/String), methods

----
```ruby
# All Symbols Ticker
all_ticker methods:
```
* required params: methods

----
```ruby
# Symbol Snapshot
# Market Snapshot
snapshot symbol:, methods:
```
* required params: symbol, methods
* alias methods: symbol_snapshot, market_snapshot

----
```ruby
# Level-2 Market Data
level_2_market_data symbols:, methods:
```
* required params: symbols(Array/String), methods

----
```ruby
# Match Execution Data
match_execution_data symbols:, methods:, private_channel: false
```
* required params: symbols(Array/String), methods

----
```ruby
# Full MatchEngine Data(Level 3)
full_match_engine_data symbols:, methods:, private_channel: false
```
* required params: symbols(Array/String), methods

#### Private Channels
----

```ruby
# Stop order received event
# Stop order activate event
stop_order_received_event symbols:, methods:
```
* required params: symbols(Array/String), methods
* alias methods: stop_order_activate_event

----
```ruby
# Account balance notice
balance methods:
```
* required params: methods

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mwlang/kucoin-api.

## Inspiration

The inspiration for architectural layout of this gem comes nearly one-for-one from the [Binance gem](https://github.com/craysiii/binance) by craysiii.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
