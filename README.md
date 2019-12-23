## Ascenda test

- Production link: **https://ascenda.herokuapp.com/hotels**

### I - Set up project at localhost

```bash
git clone git@github.com:lucas2804/ascenda_test.git
cd ascenda_test
bundle install

mysql.server start
rake db:setup
rake db:migrate
rspec

curl http://localhost:3000/hotels/sync_data
curl http://localhost:3000/hotels
curl http://localhost:3000/?hotel_ids[]=iJhz&destination_ids[]=5432
```

#### 1) Sync hotel data endpoint

```bash
curl http://localhost:3000/hotels/sync_data
```

```json
{"message":"Sync data successfully from Supplier1 2 3","total_hotels":3}
```

#### 2) Search hotels depends on hotel_ids and destination_ids

```bash
curl http://localhost:3000/?hotel_ids[]=iJhz&destination_ids[]=5432
```

```mysql
SELECT `hotels`.* FROM `hotels` WHERE `hotels`.`hotel_id` = 'iJhz';

SELECT `hotels`.* FROM `hotels` WHERE `hotels`.`hotel_id` = 'iJhz' AND `hotels`.`hotel_id` = '5432' AND `hotels`.`hotel_id` = '5432' AND `hotels`.`hotel_id` = '5432';
```

#### 3) Get hotel data endpoint

```bash
curl http://localhost:3000/hotels
```

```json
[
  {
    "id": "iJhz",
    "destination_id": 5432,
    "name": "Beach Villas Singapore",
    "location": {
      "lat": 1.26475,
      "lng": 103.824,
      "address": "8 Sentosa Gateway, Beach Villas, 098269",
      "city": "Singapore",
      "country": "Singapore"
    },
    "description": "This 5 star hotel is located on the coastline of Singapore.",
    "amenities": {
      "general": [
        {
          "name": "pool",
          "category": "general"
        }
      ],
      "room": [
        {
          "name": "pool",
          "category": "general"
        },
        {
          "name": "tub",
          "category": "general"
        }
      ]
    },
    "images": {
      "rooms": [
        {
          "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
          "description": "Double room"
        },
        {
          "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg",
          "description": "Double room"
        },
        {
          "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg",
          "description": "Bathroom"
        }
      ],
      "site": [
        {
          "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
          "description": "Front"
        }
      ],
      "amenities": [
        {
          "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg",
          "description": "RWS"
        },
        {
          "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg",
          "description": "Sentosa Gateway"
        }
      ]
    },
    "booking_conditions": [
      "Pets are not allowed.",
      "WiFi is available in all areas and is free of charge.",
      "Free private parking is possible on site (reservation is not needed).",
    ]
  }
]
```

### II - CI/CD with Travis and Heroku

![auto-deploy.png](./images/auto-deploy.png)
![heroku.png](./images/heroku.png)
![travis-ci.png](./images/travis-ci.png)
