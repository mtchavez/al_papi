# AuthorityLabs Partner API Gem

[![Latest Version](http://img.shields.io/github/release/mtchavez/skiplist.svg?style=flat-square)](https://github.com/mtchavez/al_papi/releases)
[![Build Status](https://secure.travis-ci.org/mtchavez/al_papi.png)](http://travis-ci.org/mtchavez/al_papi?branch=master)
[![Coverage Status](https://coveralls.io/repos/mtchavez/al_papi/badge.png?branch=update%2Fdependencies)](https://coveralls.io/r/mtchavez/al_papi?branch=update%2Fdependencies)
[![Code Climate](https://codeclimate.com/github/mtchavez/al_papi.png)](https://codeclimate.com/github/mtchavez/al_papi)

A wrapper around the Partner API calls. Allows post, priority post and get calls.

## Install

```ruby
gem install 'al_papi'
```

## Configuration

Set configuration options to be used on requests:

```ruby
require 'al_papi'

AlPapi.configure do |config|
  config.api_key = 'yR43BtBDjadfavMy6a6aK0'
end
```

## Account

Account endpoint lets you get basic info about your account, current queue times and any system messages.

```ruby
# Pass your account ID into the info method
res = AlPapi::Account.info '1'

# Response body will be JSON response
res.body

# You can use the parsed_body method for convenience to access data
account_info = res.parsed_body
account_info.user.current_balance # 500.00
account_info.queue.bing_time # 15
account_info.messages.system # ['The system is back online!']
```

Example response in JSON

```javascript
{
    "messages": {
        "system": ['The system is back online!']
    },
    "queue": {
        "bing_time": 15,
        "google_time": 3,
        "yahoo_time": 2
    },
    "user": {
        "current_balance": 500.00,
        "current_get_count": 2000,
        "current_post_count": 1000,
        "hourly_get_limit": 2000,
        "hourly_post_limit": 1000
    }
}
```

## Keywords

Keywords endpoint allows you to POST keywords you want SERPs for and to GET those results
when they are ready.

### POST

Post your keyword-engine-locale combination to the API:

```ruby
res = AlPapi::Keyword.post keyword: "Centaur Love'n", engine: 'google', locale: 'en-us'

if res.success?
  p 'Centaur High Hoof'
else
  p 'PAPI Fail'
end
```

### Priority POST

Post your keyword to the priority queue if you need results in a more timely manner:

```ruby
res = AlPapi::Keyword.priority_post keyword: "Mad Scientist", engine: 'bing', locale: 'en-ca'

if res.success?
  p 'Canadian Bing Scientist Time'
else
  p 'PAPI Fail'
end
```

### GET

When you are ready to get your results you can do a GET request for your keyword-engine-locale combo:

```ruby
res = AlPapi::Keyword.get keyword: "Mad Scientist", engine: 'bing', locale: 'en-ca'

if res.success?
  p 'Canadian Bing Scientist Time'
  res.body # Hash of your results for that keyword-engine-locale
else
  p 'PAPI Fail'
end
```

### Response

When making an API request a response object is returned with any errors, http response code and http reponse body.

```ruby
res = req.get keyword: "Mad Scientist", engine: 'bing', locale: 'en-ca'

# Errors:
# Returns an array of error objects.
res.errors

if res.errors.present?
  res.errors.each do |error|
    p error.code      # http repsonse code
    p error.message   # error message
    p error.params    # params of request
    p error.path      # path of request
  end
end

# Success:
# Returns true or false if request was successful or not.
res.success?

# Body:
# Returns body of response.
# On GET requests the body will be a hash of your results if successful.
res.body

# Parsed Body:
# Returns the parsed JSON body, if present, as a Hashie::Mash object.
# This can be useful to get an object with methods to call instead of
# indexing into nested hashes.

# Code:
# Returns http response code.
# 204: On GET requests when no data is available yet
# 200: Successful
# 401: Invalid api key
# 500: Server Error
res.code

# Over Limit:
# Returns true or false if over hourly limit
res.over_limit?

# Suspended:
# Returns true or false if your account has been suspended
res.suspended?
```

## Web Insight

### Description

Web Insight queue takes a URL for the Partner API to scrape and parse out high level insight about the page
and return the results to your callback URL passed in or set for your account.

### POST

Post the URL of the page you want to gain insight into and the callback URL knowing when your results are
ready to get.

```ruby
res = AlPapi::WebInsight.post url: 'http://www.qwiki.com', callback: 'http://your-callback-url.com'
```

### GET

When your results are ready to get you will receive a callback that contains the information on how
to get the insight on your URL. In the callback you should receive a date_created and time_created to use
in your get request. You will also use your original URL posted.

```ruby
res = AlPapi::WebInsight.get url: 'http://www.qwiki.com', date_created: '2012-06-14', time_created: '01:50'
```

## Extras

### Engines

Supported engines are Google, Yahoo and Bing. To get a list of supported engines run the following:

```ruby
AlPapi::Engines.all
```

### Locales

Supported locales differ by the engine being used. In order to make sure you are using a supported locale
for the engine you are posting a keyword to there is a locales class to help you:

### Supported

A way to see all the supported locales for a specified engine

```ruby
AlPapi::Locales.supported # defaults to google
```

Example response

```javascript
{
  engine: google
  locales: {
    ko-kr: {
      description: Korea - Korean
      tld: http://www.google.co.kr
    },
    ...
    el-gr: {
      description: Greece - Greek
      tld: http://www.google.gr
    }
  }
  supported: true
}
```

### Description

You can query the API to see if a specific locale is supported for an engine and get a description of that locale.

```ruby
AlPapi::Locales.description 'google', 'ko-kr'
```

Example response

```javascript
{
  locale: ko-kr
  description: Korea - Korean
  supported: true
  engine: google
}
```
