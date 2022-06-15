# Sweater Wheather

Welcome to the SweaterWheather app! This was an academic challenge app made for `Turing School of Software and Design`, and is an API Rails backend application for some *supposed* frontend of a service-oriented architecture. The goals of this project were to practice exposing API endpoints that (1) aggregate data from multiple external API's, (2) enable CRUD function, and (3) require and authenticate an API token.

## Setup

1. Clone this repo, and run the commands: `bundle`, `rails db:create`, `rails db:migrate`
2. Open `config/application.yml` and set the following api keys as environmental variables (if you need to obtain any of these keys, click the link to the right. As of publication, these resources are all free for limited use):
```Ruby
  mapquest_api_key: [set to your [mapquest api key][https://developer.mapquest.com/user/login/sign-up]]
  openweather_api_key: [set to your own [openweather api key][https://home.openweathermap.org/subscriptions/billing_info/onecall_30/base?key=base&service=onecall_30]]
  unsplash_api_key: [set to your own [unsplash api key][https://unsplash.com/developers]]
```
3. Run `bundle exec rspec` and ensure all tests are passing
4. Run `rails s`
5. Congratulations - your API is now running on localhost:3000!

## Use

This API has 5 endpoints, and each endpoint has strict requirements for incoming requests:

### Weather for a City

Example request;
```
  GET /api/v1/forecast?location=denver,co
  headers: {
    Content-Type: application/json,
    Accept: application/json
  }
```
The weather for a city endpoint uses mapquest's geocoding api to feed coordinate data into the open weather API and returns whether forecast data over the next 48 hours/7days at the location indicated by the `location` parameter. It requires the parameter be present and not empty, and that Content-Type and Accept be set to "application/json" in the request header.

Successful response;
```JSON
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2022-06-15T07:29:01.000+00:00",
                "temperature": "62 F",
                "sunrise": "2022-06-15T03:22:16.000+00:00",
                "sunset": "2022-06-15T19:30:58.000+00:00",
                "feels_like": "60 F",
                "humidity": 54,
                "uvi": 2.13,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01d"
            },
            "daily_weather": [
                {
                    "date": "2022-06-15",
                    "sunrise": "2022-06-15T03:22:16.000+00:00",
                    "sunset": "2022-06-15T19:30:58.000+00:00",
                    "max_temp": "80 F",
                    "min_temp": "55 F"
                },
                {
                    "date": "2022-06-16",
                    "sunrise": "2022-06-16T03:22:13.000+00:00",
                    "sunset": "2022-06-16T19:31:25.000+00:00",
                    "max_temp": "78 F",
                    "min_temp": "58 F"
                },
                {
                    "date": "2022-06-17",
                    "sunrise": "2022-06-17T03:22:12.000+00:00",
                    "sunset": "2022-06-17T19:31:50.000+00:00",
                    "max_temp": "77 F",
                    "min_temp": "56 F"
                },
                {
                    "date": "2022-06-18",
                    "sunrise": "2022-06-18T03:22:15.000+00:00",
                    "sunset": "2022-06-18T19:32:12.000+00:00",
                    "max_temp": "87 F",
                    "min_temp": "59 F"
                },
                {
                    "date": "2022-06-19",
                    "sunrise": "2022-06-19T03:22:20.000+00:00",
                    "sunset": "2022-06-19T19:32:32.000+00:00",
                    "max_temp": "88 F",
                    "min_temp": "62 F"
                }
            ],
            "hourly_weather": [
                {
                    "time": "2022-06-15T07:00:00.000Z",
                    "temperature": "62 F",
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "2022-06-15T08:00:00.000Z",
                    "temperature": "63 F",
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "2022-06-15T09:00:00.000Z",
                    "temperature": "66 F",
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "2022-06-15T10:00:00.000Z",
                    "temperature": "70 F",
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "2022-06-15T11:00:00.000Z",
                    "temperature": "74 F",
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            ]
        }
    }
}
```

### Background Image Endpoint

Example request:
```
  GET /api/v1/backgrounds?location=denver,co
  headers: {
    Content-Type: application/json,
    Accept: application/json
  }
```
The background image endpoint searches the unsplash image search endpoint for images tagged with the target city, and repackages information with attributions in accordance with [unsplash's guidelines][https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines]

Successful response:
```json
{
    "data": {
        "type": "image",
        "id": null,
        "attributes": {
            "image": {
                "location": "Ontario,CA",
                "image_url": "https://images.unsplash.com/photo-1598279253890-7f363003ffa3?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzczODh8MHwxfHNlYXJjaHwxfHxPbnRhcmlvJTJDQ0F8ZW58MHx8fHwxNjU1MjgwNjA5&ixlib=rb-1.2.1&q=80",
                "credit": {
                    "source": "unsplash.com",
                    "author": [
                        "Narciso Arellano",
                        "https://api.unsplash.com/users/el_chicho",
                        "https://images.unsplash.com/photo-1598279253890-7f363003ffa3?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzczODh8MHwxfHNlYXJjaHwxfHxPbnRhcmlvJTJDQ0F8ZW58MHx8fHwxNjU1MjgwNjA5&ixlib=rb-1.2.1&q=80"
                    ],
                    "author_link": "https://api.unsplash.com/users/el_chicho",
                    "logo": "https://pixabay.com/static/img/logo_square.png"
                }
            }
        }
    }
}
```

### User Registration Endpoint

Example request
```
  POST /api/v1/users
  headers: {
    Content-Type: application/json,
    Accept: application/json
  },
  body: {
    "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
  }
```

The user registration endpoint allows the front end to post a new user to the `users` table of the backend database, if the email is formatted as an email and the passwords match. Passwords are not saved directly to the database, but are hashed and authenticated using `bcrypt`. Incoming requests to this endpoint must have JSON body that contains `"email"`, `"password"` and `"password_confirmation"` keys; they cannot be passed pas query params.

Successful response
```JSON
{
    "data": {
        "type": "users",
        "id": 4,
        "attributes": {
            "email": "booper.pooper@dogmail.com",
            "api_key": "1234567890e932b889119525fd0ff3f5"
        }
    }
}
```

### User Validation Endpoint

Example request
```
  POST /api/v1/sessions
  headers: {
    Content-Type: application/json,
    Accept: application/json
  },
  body: {
    "email": "whatever@example.com",
    "password": "password"
  }
```

The user validation endpoint validate's a user's log-in by checking the email is just an email, finding the associated user and validating the provided password against that user account with bcrypt's `validate` method. This endpoint requires that `email` and `password` are again sent as keys in a JSON body, not as query parameters.

Successful response
```JSON
{
    "data": {
        "type": "users",
        "id": 4,
        "attributes": {
            "email": "booper.pooper@dogmail.com",
            "api_key": "1234567890e932b889119525fd0ff3f5"
        }
    }
}
```

### Roadtrip Endpoint

Example request
```
  POST /api/v1/road_trip
  headers: {
    Content-Type: application/json,
    Accept: application/json
  },
  body: {
    "origin": "NewYork,ny",
    "destination": "Denver,co",
    "api_key": "1234567890e932b889119525fd0ff3f5"
  }
```

The Roadtrip endpoint takes the extra validation step of verifying the request body has a valid API key that is registerd to the database. If so, this endpoint synthesizes data from a second mapquest api endpiont to generated an expected forecast in a destination city based on expected travel time, with some checks for impossible road trips. With this endpoint, all pareters msut come in as keys in a JSON body, not in query parameters in the URL, and as with all endpoints headers `Content-Type` and `Accept` must be `application/json`

Successful response
```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Westminster,CO",
            "end_city": "Baily,co",
            "travel_time": "0 hours, 57 minutes",
            "weather_at_eta": {
                "temperature": 288.59,
                "conditions": "clear sky"
            }
        }
    }
}
```
