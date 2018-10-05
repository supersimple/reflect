// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("mirror:data", {})
let currentWeatherTempContainer = document.querySelector("#current_weather h1.temp")
let currentWeatherIconContainer = document.querySelector("#current_weather img.icon")

let dayOneWeatherIconContainer = document.querySelector("#day_one_weather img.icon")
let dayOneWeatherHighContainer = document.querySelector("#day_one_weather h2.high_temp")
let dayOneWeatherLowContainer = document.querySelector("#day_one_weather h2.low_temp")

let dayTwoWeatherIconContainer = document.querySelector("#day_two_weather img.icon")
let dayTwoWeatherHighContainer = document.querySelector("#day_two_weather h2.high_temp")
let dayTwoWeatherLowContainer = document.querySelector("#day_two_weather h2.low_temp")

let dayThreeWeatherIconContainer = document.querySelector("#day_three_weather img.icon")
let dayThreeWeatherHighContainer = document.querySelector("#day_three_weather h2.high_temp")
let dayThreeWeatherLowContainer = document.querySelector("#day_three_weather h2.low_temp")

let dayFourWeatherIconContainer = document.querySelector("#day_four_weather img.icon")
let dayFourWeatherHighContainer = document.querySelector("#day_four_weather h2.high_temp")
let dayFourWeatherLowContainer = document.querySelector("#day_four_weather h2.low_temp")

let dayFiveWeatherIconContainer = document.querySelector("#day_five_weather img.icon")
let dayFiveWeatherHighContainer = document.querySelector("#day_five_weather h2.high_temp")
let dayFiveWeatherLowContainer = document.querySelector("#day_five_weather h2.low_temp")

let daySixWeatherIconContainer = document.querySelector("#day_six_weather img.icon")
let daySixWeatherHighContainer = document.querySelector("#day_six_weather h2.high_temp")
let daySixWeatherLowContainer = document.querySelector("#day_six_weather h2.low_temp")

channel.on("new_data", payload => {
  currentWeatherTempContainer.innerText = payload.current_weather.temperature
  currentWeatherIconContainer.src = payload.current_weather.icon

  dayOneWeatherIconContainer.src =       payload.day_one_weather.icon
  dayOneWeatherHighContainer.innerText = payload.day_one_weather.high
  dayOneWeatherLowContainer.innerText =  payload.day_one_weather.low

  dayTwoWeatherIconContainer.src =       payload.day_two_weather.icon
  dayTwoWeatherHighContainer.innerText = payload.day_two_weather.high
  dayTwoWeatherLowContainer.innerText =  payload.day_two_weather.low

  dayThreeWeatherIconContainer.src =       payload.day_three_weather.icon
  dayThreeWeatherHighContainer.innerText = payload.day_three_weather.high
  dayThreeWeatherLowContainer.innerText =  payload.day_three_weather.low

  dayFourWeatherIconContainer.src =       payload.day_four_weather.icon
  dayFourWeatherHighContainer.innerText = payload.day_four_weather.high
  dayFourWeatherLowContainer.innerText =  payload.day_four_weather.low

  dayFiveWeatherIconContainer.src =       payload.day_five_weather.icon
  dayFiveWeatherHighContainer.innerText = payload.day_five_weather.high
  dayFiveWeatherLowContainer.innerText =  payload.day_five_weather.low

  daySixWeatherIconContainer.src =       payload.day_six_weather.icon
  daySixWeatherHighContainer.innerText = payload.day_six_weather.high
  daySixWeatherLowContainer.innerText =  payload.day_six_weather.low
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
