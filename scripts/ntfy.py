#!/bin/python

import sys
import os
import requests

# if (len(sys.argv)<=1):
    # print("Usage: ntfy <server> <topic> <title> <data>")
    # sys.exit(0)

try:
    server = sys.argv[1]
except:
    server = "ntfy.sh"
try:
    topic = sys.argv[2]
except:
    topic = "notify"
try:
    title = sys.argv[3]
except:
    title = "Computer"
try:
    data = sys.argv[4]
except:
    data = "Some Notification Content"
    
requests.post(f"http://{server}/{topic}",
    data=f"{data}",
    headers={
        "Title": f"{title}",
        "Priority": "urgent",
        "Tags": "computer"
    })

