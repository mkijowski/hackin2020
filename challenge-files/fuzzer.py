#!/usr/bin/env python3
import http.client


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
	# needs to be implemented


if __name__ == "__main__":
	wordlist = read_from_file()
	connect(wordlist)
