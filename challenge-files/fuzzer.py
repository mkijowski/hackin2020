#!/usr/bin/env python3
import http.client
import requests

target_url     = "http://evil.ru.site:8080/"
user_agent     = "Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20100101 Firefox/19.0"

def read_from_file():
	# create wordlist array
	wordlist = []

	# read wordlist into array
	with open('wordlist.txt') as input_file:
		for word in input_file:
			wordlist.append(word)

	# fuzz the malicious server
	return wordlist


def connect(wordlist):
    for word in wordlist:
        url = "%s%s" % (target_url,word)
        url = url.strip()
        r = requests.get(url)
        print(url,", ", r)


if __name__ == "__main__":
	wordlist = read_from_file()
	connect(wordlist)
