# Bus Times 
Using Transport For London’s API, this app gives users bus information, of the local bus stops within a 300 radius. The app opens with a map of where the user is currently. Annotations pins are displayed on the map, that represent each bus stop. Each annotation displays the next bus to arrive, and with the number of minutes till it arrives. 

## TFL API
TFL provides serval REST API’s, from accident information to air quality, bike points and bus and the London Underground. To use the API, latitude and longitude coordinates are required to the API. For information on the TLF’s API, visit the TLF’s website at https://api.tfl.gov.uk/ . 

## Development 
Core Location Framework – 
To develop this app, Core Location framework is used, to get the user’s current latitude and longitude, which is used make an REST API requests, to get all the local bus stops within where the user is. 

## Codable  
I use Codable to parse the Json data that is retrieved, which provides bus information for each stop, such as the latitude and longitude coordinates of the stop, buses, and arrival time. 

## Mapkit Framework 
mapkit Frameworkis used to display a map, with the user’s current location and annotation pins which represent bus stops. 

## UserDefaults 
UserDefaults is used to save the user’s location, bus stops and the information of each stop. I used UserDefaults, because of the ease of use, plus the app will be saving small amount of data. 





