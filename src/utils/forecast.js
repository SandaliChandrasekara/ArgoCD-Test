require("dotenv").config();

const request = require("request");

const forecast = (latitude, longitude, callback) => {
  const url = `http://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${process.env.OPENWEATHER_API_KEY}&units=metric`;

  request({ url, json: true }, (error, response, body) => {
    if (error) {
      callback("Unable to connect to weather service!", undefined);
    } else if (body.cod && body.message) {
      callback("Unable to find location", undefined);
    } else {
      callback(
        undefined,
        `${body.weather[0].description}. It is currently ${body.main.temp} degrees out. There is a ${body.clouds.all}% chance of rain.`
      );
    }
  });
};

module.exports = forecast;
