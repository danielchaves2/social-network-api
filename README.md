# Social Network Highlights API

SNH is an API to get the highlights from the most popular social networks:

* https://takehome.io/twitter
* https://takehome.io/facebook
* https://takehome.io/instagram


## Requirements

Ruby 3.0 or above

## Installation

Clone the project and run the following command from the root directory

```bash
bundle install
```

## Usage

Run the command below to start the server locally

```bash
ruby server.rb
```

#### Request Example

```bash
curl localhost:3000
```
#### Response Example
```json
{"facebook":{"statuses":[{"name":"Some Friend","status":"Here's some photos of my holiday. Look how much more fun I'm having than you are!"},{"name":"Drama Pig","status":"I am in a hospital. I will not tell you anything about why I am here."}]},"twitter":{"tweets":[{"username":"@GuyEndoreKaiser","tweet":"If you live to be 100, you should make up some fake reason why, just to mess with people... like claim you ate a pinecone every single day."},{"username":"@mikeleffingwell","tweet":"STOP TELLING ME YOUR NEWBORN'S WEIGHT AND LENGTH I DON'T KNOW WHAT TO DO WITH THAT INFORMATION."}]},"instagram":{"photos":[{"username":"hipster1","picture":"food"},{"username":"hipster2","picture":"coffee"},{"username":"hipster3","picture":"coffee"},{"username":"hipster4","picture":"food"},{"username":"hipster5","picture":"this one is of a cat"}]}}
```

## Testing

Run the command below to execute the unit test cases

```bash
rspec
```

After running the tests, a complete test coverage report can be found in file **coverage/index.html**.

## Next  steps

* Async calls with [Typhoeus](https://github.com/typhoeus/typhoeus) adapter for Faraday