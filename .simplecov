# frozen_string_literal: true

SimpleCov.start do
  add_filter '/spec/'
  add_group 'Rest',         ['lib/kucoin/api/rest', 'lib/kucoin/api/rest.rb']
  add_group 'Websocket',    ['lib/kucoin/api/websocket.rb']
  add_group 'Endpoints',    'lib/kucoin/api/endpoints'
  add_group 'Middleware',   'lib/kucoin/api/middleware'
end
