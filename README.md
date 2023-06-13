# Sweater Weather

Sweater Weather is a back-end application built with Ruby on Rails that exposes an API to provide data on forecast and travel conditions to a fictional front-end application. It aggregates data from multiple external API endpoints and handles user registration, log-in with authentication, and token authentication to access requests. This application presumes the team is working in a service-oriented architecture pattern, and follows RESTful API conventions. 

## Learning Goals

This project is part of the Turing School of Software + Design's Back-End Engineering track, and is the final solo project for Module 3. See more details about the project requirements [here](https://backend.turing.edu/module3/projects/sweater_weather/). Completing this application demonstrates:
- Exposing an API that aggregates data from multiple external APIs
- Exposing an API that requires an authentication token
- Exposing an API for CRUD functionality

Additionally, through this project, I have gained practice determining appropriate response content and format, based on the needs of a front-end team.

## Installation

### Running the Application Locally

1. Clone this repository from the command line: <br>
`git clone git@github.com:cariperi/sweater_weather.git`

2. Navigate to your local repository: <br>
`cd sweater_weather`

3. Install dependencies and gems: <br>
`bundle install`

4. Set up the database and run migrations: <br>
`rails db:{create, migrate}`

5. Configure [Figaro](https://github.com/laserlemon/figaro) to hide environment secret variables (see below): <br>
`bundle exec figaro install`

6. Start the Rails server: <br>
`rails s`

With your local server running, you can use a tool like [Postman](https://www.postman.com/) or the [ThunderClient](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client) extension for VS Code to make sample requests and view responses.

### External API Integrations

Sweater Weather's endpoints expose data from Mapquest and the Weather API. The app also uses the [Timezone](https://github.com/panthomakos/timezone) gem to handle timezone lookup by coordintes, which works by integrating with Google's Timezone API.

You can sign up for free access to these APIs here:
- [MapQuest](https://developer.mapquest.com/) (Geocoding endpoint, Directions endpoint)
- [Weather API](https://www.weatherapi.com/docs/) (Forecast endpoint)
- [Google Places](https://developers.google.com/maps/documentation/timezone/overview) (Timezone endpoint)

Once you have your key for each site, add them to the `config/application.yml` file generated when you configure Figaro (see Step 5, above). Please ensure you include the exact variable names below:

```ruby
MAPQUEST_API_KEY: <add your key here>
WEATHER_API_KEY: <add your key here>
GOOGLE_API_KEY: <add your key here>
```

## Testing

To run the full test suite: `bundle exec rspec`

Sweater Weather uses [Simplecov](https://github.com/simplecov-ruby/simplecov) to monitor test coverage. At the time of writing, test coverage was at 100% with all tests passing. [VCR](https://github.com/vcr/vcr) with [Webmock](https://github.com/bblimke/webmock) is used to mock calls to external APIs.

## Endpoints

### 1. Retrieve Weather for a City

GET `/api/v0/forecast?location={location}` <br>
- Pass the <b>location</b> as a query parameter in the request.

<details>
  <summary><b>Successful Response - Example</b></summary>
  
  ``` json
 {
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2023-06-13 15:45",
                "condition": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                "temperature": 78.1,
                "feels_like": 77.4,
                "humidity": 32.0,
                "uvi": 7.0,
                "visibility": 9.0
            },
            "daily_weather": [
                {
                    "date": "2023-06-13",
                    "sunrise": "05:32 AM",
                    "sunset": "08:30 PM",
                    "condition": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "max_temp": 79.0,
                    "min_temp": 58.5
                },
                {
                    "date": "2023-06-14",
                    "sunrise": "05:32 AM",
                    "sunset": "08:30 PM",
                    "condition": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png",
                    "max_temp": 70.9,
                    "min_temp": 60.1
                },
                {
                    "date": "2023-06-15",
                    "sunrise": "05:32 AM",
                    "sunset": "08:31 PM",
                    "condition": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "max_temp": 77.9,
                    "min_temp": 55.4
                },
                {
                    "date": "2023-06-16",
                    "sunrise": "05:32 AM",
                    "sunset": "08:31 PM",
                    "condition": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png",
                    "max_temp": 79.7,
                    "min_temp": 63.7
                },
                {
                    "date": "2023-06-17",
                    "sunrise": "05:32 AM",
                    "sunset": "08:32 PM",
                    "condition": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png",
                    "max_temp": 78.3,
                    "min_temp": 58.3
                }
            ],
            "hourly_weather": [
                {
                    "time": "2023-06-13 00:00",
                    "conditions": "Cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/119.png",
                    "temperature": 62.4
                },
                {
                    "time": "2023-06-13 01:00",
                    "conditions": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/176.png",
                    "temperature": 61.2
                },
                {
                    "time": "2023-06-13 02:00",
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                    "temperature": 60.4
                },
                {
                    "time": "2023-06-13 03:00",
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                    "temperature": 59.9
                },
                {
                    "time": "2023-06-13 04:00",
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                    "temperature": 59.2
                },
                {
                    "time": "2023-06-13 05:00",
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                    "temperature": 58.3
                },
                {
                    "time": "2023-06-13 06:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 57.9
                },
                {
                    "time": "2023-06-13 07:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 60.4
                },
                {
                    "time": "2023-06-13 08:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 63.7
                },
                {
                    "time": "2023-06-13 09:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 66.9
                },
                {
                    "time": "2023-06-13 10:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 70.0
                },
                {
                    "time": "2023-06-13 11:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 73.0
                },
                {
                    "time": "2023-06-13 12:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 75.0
                },
                {
                    "time": "2023-06-13 13:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 76.6
                },
                {
                    "time": "2023-06-13 14:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 77.7
                },
                {
                    "time": "2023-06-13 15:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 78.4
                },
                {
                    "time": "2023-06-13 16:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 78.1
                },
                {
                    "time": "2023-06-13 17:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 77.7
                },
                {
                    "time": "2023-06-13 18:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 78.1
                },
                {
                    "time": "2023-06-13 19:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 77.5
                },
                {
                    "time": "2023-06-13 20:00",
                    "conditions": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "temperature": 71.4
                },
                {
                    "time": "2023-06-13 21:00",
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                    "temperature": 69.4
                },
                {
                    "time": "2023-06-13 22:00",
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png",
                    "temperature": 68.0
                },
                {
                    "time": "2023-06-13 23:00",
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png",
                    "temperature": 66.6
                }
            ]
        }
    }
}
  ```
</details>

### 2. User Registration

POST `/api/v0/users` <br>
- Pass parameters for <b>email</b>, <b>password</b>, and <b>password_confirmation</b> as a JSON payload in the body of the request.
```json
{
  "email": "test@test.com",
  "password": "password",
  "password_confirmation": "password"
}
```

<details>
  <summary><b>Successful Response - Example</b></summary>
  
  ``` json
 {
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "test@test.com",
            "api_key": "b10c04c558e857071c6d07496a54dfe2"
        }
    }
}
  ```
</details>

### 3. User Log-In

POST `/api/v0/sessions` <br>
- Pass parameters for <b>email</b> and <b>password</b> as a JSON payload in the body of the request.
```json
{
  "email": "test@test.com",
  "password": "password"
}
```

<details>
  <summary><b>Successful Response - Example</b></summary>
  
  ``` json
 {
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "test@test.com",
            "api_key": "b10c04c558e857071c6d07496a54dfe2"
        }
    }
}
  ```
</details>

### 4. Plan a Road Trip

POST `/api/v0/road_trip` <br>
- Pass parameters for <b>origin</b>, <b>destination</b>, and <b>api_key</b> as a JSON payload in the body of the request.
```json
{
  "origin": "New York, NY",
  "destination": "Los Angeles, CA",
  "api_key": "092f1cea9b9ac084253c627eaeff668b"
}
```

<details>
  <summary><b>Successful Response - Example</b></summary>
  
  ``` json
  {
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "New York, NY",
            "end_city": "Los Angeles, CA",
            "travel_time": "38h 47m",
            "weather_at_eta": {
                "datetime": "2023-06-15 03:00",
                "temperature": 62.8,
                "condition": "Overcast"
            }
        }
    }
}
  ```
</details>

## Current Status + Next Steps

Sweather Weather completes the projcet requirements as outlined [here](https://backend.turing.edu/module3/projects/sweater_weather/requirements), including four endpoints:
- Retrieve weather for a city
- User registration
- User log-in
- Plan a road trip with travel time / forecast

These endpoints handle both happy paths as well as sad paths and potential edge cases (ex. credentials not provided, incorrect credentials provided, missing parameters, impossible trip requests, etc.).

Going forward, additional features to be added to this application may include:
- Retrieving images for a specific city and weather condition to display on show page
- Adding query parameters to endpoints such as 'units' to allow users to select metric or imperial units (Celcius / Farenheit, kilometers / miles, etc.)
- Adding versioning and / or pagination to the endpoints
