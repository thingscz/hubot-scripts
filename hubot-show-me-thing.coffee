# Parse Things.cz simple API JSON (just add your Things.cz token to ADD_YOUR_TOKEN_HERE on row 9 and that's it).
#
# hubot show me thing <DevEUI> - returns DevEUI last payload
#

module.exports = (robot) ->
  robot.respond /show me thing (.*)/i, (msg) ->
    deveui = escape(msg.match[1])
    msg.http("https://things1.bootlab.cz/api/simple/uplink-v1?token=ADD_YOUR_TOKEN_HERE&deveui=#{deveui}&extended=no")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send "DevEUI : #{json.deveui}\n
          timestamp (GMT) : #{json.timestamp_gmt_iso8601}\n
          payload (hex) : #{json.payload_hex}\n
          gateway RSSI (dBm) : #{json.rssi}\n"
        catch error
          msg.send "I am sorry, mate. Something is broken."