module GeoNamesAPI
  class Children < ListEndpoint

    METHOD = "childrenJSON"
    FIND_PARAMS = %w(geonameId maxRows)

  end
end

=begin
{
  "totalResultsCount": 20,
  "geonames": [
    {
      "alternateNames": [
        {
          "name": "els Abruços",
          "lang": "ca"
        },
        {
          "name": "Abruzzen",
          "lang": "de"
        },
        {
          "name": "Abruzzo",
          "lang": "en"
        },
        {
          "name": "Los Abruzos",
          "lang": "es"
        },
        {
          "name": "Abruzzes",
          "lang": "fr"
        },
        {
          "name": "Abruzzo",
          "lang": "it"
        },
        {
          "name": "http://en.wikipedia.org/wiki/Abruzzo",
          "lang": "link"
        },
        {
          "name": "Abruzzen",
          "lang": "nl"
        }
      ],
      "countryName": "Italy",
      "adminCode1": "01",
      "lng": "13.75",
      "adminName2": "",
      "fcodeName": "first-order administrative division",
      "adminName3": "",
      "timezone": {
        "dstOffset": 2,
        "gmtOffset": 1,
        "timeZoneId": "Europe/Rome"
      },
      "adminName4": "",
      "adminName5": "",
      "bbox": {
        "south": 41.68307876586914,
        "east": 14.783888816833496,
        "north": 42.8957405090332,
        "west": 13.019405364990234
      },
      "name": "Abruzzo",
      "fcode": "ADM1",
      "geonameId": 3183560,
      "lat": "42.25",
      "population": 1338898,
      "adminName1": "Abruzzo",
      "countryId": "3175395",
      "adminId1": "3183560",
      "fclName": "country, state, region,...",
      "countryCode": "IT",
      "wikipediaURL": "",
      "toponymName": "Regione Abruzzo",
      "fcl": "A",
      "numberOfChildren": 4,
      "continentCode": "EU"
    },

=end
