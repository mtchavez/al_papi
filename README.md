AuthorityLabs Partner API Gem
=============================

A wrapper around the Partner API calls. Allows post, priority post and get calls.

* Github: http://github.com/mtchavez/al_papi

## Install

	gem install 'al_papi'

## Usage
	
Make a request object using your api key:

	require 'al_papi'

	req = AlPapi::Request.new(api_key: 'yR43BtBDjadfavMy6a6aK0')

### POST
	
Post your keyword-engine-locale combination to the API:

	res = req.post keyword: "Centaur Love'n", engine: 'google', locale: 'en-us'
		
	if res.success?
		p 'Centaur High Hoof'
	else
		p 'PAPI Fail'
	end

### Priority POST
	
Post your keyword to the priority queue if you need results in a more timely manner:

	res = req.priority_post keyword: "Mad Scientist", engine: 'bing', locale: 'en-ca'
		
	if res.success?
		p 'Canadian Bing Scientist Time'
	else
		p 'PAPI Fail'
	end

### GET

When you are ready to get your results you can do a GET request for your keyword-engine-locale combo:
	
	res = req.get keyword: "Mad Scientist", engine: 'bing', locale: 'en-ca'
		
	if res.success?
		p 'Canadian Bing Scientist Time'
		res.body # Hash of your results for that keyword-engine-locale
	else
		p 'PAPI Fail'
	end

### Response

When making an API request a response object is returned with any errors, http response code and http reponse body.

	res = req.get keyword: "Mad Scientist", engine: 'bing', locale: 'en-ca'
	
	# Errors:
	# Returns an array of error objects.
	res.errors
	
	if res.errors.present?
		res.errors.each do |error|
			p error.code			# http repsonse code
			p error.message		# error message
			p error.params		# params of request
			p error.path			# path of request
		end
	end
	
	# Success:
	# Returns true or false if request was successful or not.
	res.success?
	
	# Body:
	# Returns body of response.
	# On GET requests the body will be a hash of your results if successful.
	res.body
	
	# Code:
	# Returns http response code.
	# 204: On GET requests when no data is available yet
	# 200: Successful
	# 401: Invalid api key
	# 500: Server Error
	res.code
	
### Engines

Supported engines are Google, Yahoo and Bing. To get a list of supported engines run the following:

	AlPapi::Engines.all
	
### Locales

Supported locales differ by the engine being used. In order to make sure you are using a supported locale
for the engine you are posting a keyword to there is a locales class to help you:

	AlPapi::Locales.supported # returns an array of locales for the default engine Google
	AlPapi::Locales.supported 'bing' # for other engines pass in the engine name
	AlPapi::Locales.supported 'yahoo'

## License

Written by Chavez

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
