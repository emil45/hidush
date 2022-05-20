import json
import os
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import List

import functions_framework
import firebase_admin
from flask import Request
from firebase_admin import credentials
from firebase_admin import firestore
from contentful import Client, Entry
from google.cloud.firestore_v1 import CollectionReference

SPACE_ID = "1iyxb3e05tph"
CMS_API_KEY = os.environ["CMS_API_KEY"]
CMS_HEADER_KEY = "k1k1k1k1"
LANG = 'he-IL'


@dataclass
class Hidush:
	id: str
	source: str
	sourceDetails: str
	quote: str
	peroosh: str
	rabbi: str
	categories: List[str]
	lastUpdate: datetime


cred = credentials.Certificate(
	Path(__file__).parent / "serviceAccountKey.json")
firebase_admin.initialize_app(cred, {'projectId': "hidush-1337"})

db = firestore.client()
hidushim_collection: CollectionReference = db.collection('hidushim')

client = Client(space_id=SPACE_ID, access_token=CMS_API_KEY)


def serialize_string_entry(string_entry: dict) -> str:
	"""
	Serialize to formatted string, for example in case there is BOLD characters.
	Bold characters will be prefixed with __ and postfixed with __.
	"""
	formatted_string = ""

	for string_content in string_entry['content'][0]['content']:
		if any(mark['type'] == "bold" for mark in string_content['marks']):
			formatted_string += f"*{string_content['value']}*"
		else:
			formatted_string += string_content['value']

	return formatted_string


def serialize_entry_field(entry_field: str) -> str:
	entry_field = entry_field.replace("\'", "\"")
	return json.loads(entry_field)[LANG]


def serialize_request(request_json) -> Hidush:
	entry = Entry(item=request_json)
	return Hidush(
		id=entry.id,
		quote=serialize_string_entry(entry.quote[LANG]),
		peroosh=serialize_string_entry(entry.peroosh[LANG]),
		source=serialize_entry_field(entry.source),
		sourceDetails=serialize_entry_field(entry.source_details),
		rabbi=serialize_entry_field(entry.rabbi),
		categories=entry.raw['fields']['categories'][LANG],
		lastUpdate=entry.updated_at,
	)


def upsert_entry(entry: Hidush):
	if hidushim_collection.document(entry.id).get().exists:
		hidushim_collection.document(entry.id).update(vars(entry))
		print(f"Successfully updated the entry. Entry: {entry.id}")
	else:
		hidushim_collection.add(
			{**vars(entry), 'likes': 0, 'shares': 0}, entry.id)
		print(f"Successfully created new entry. Entry: {entry.id}")


def delete_hidush(entry_id: str):
	if hidushim_collection.document(entry_id).get().exists:
		hidushim_collection.document(entry_id).delete()
		print(f"Entry deleted successfully. Entry: {entry_id}")
	else:
		print(f"Entry does not exists. Entry: {entry_id}")


@functions_framework.http
def main_upsert_hidush(request: Request):
	if request.headers.get('X-Key') != CMS_HEADER_KEY:
		return "Invalid key", 403
	print("[INFO] Starting the script")
	print(f"Request: {request}, Type: {type(request)}")
	request_json = request.get_json(silent=True)
	print(f"[INFO] Request JSON: {request_json}")
	entry = serialize_request(request_json)
	print(f"[INFO] Entry: {entry}")
	upsert_entry(entry)
	print("Finished the script")
	return 'success'


@functions_framework.http
def main_delete_hidush(request: Request):
	if request.headers.get('X-Key') != CMS_HEADER_KEY:
		return "Invalid key", 403
	print("[INFO] Starting the script")
	print(f"Request: {request}, Type: {type(request)}")
	request_json = request.get_json(silent=True)
	print(f"[INFO] Request JSON: {request_json}")
	entry = Entry(item=request_json)
	print(f"[INFO] Entry: {entry}")
	delete_hidush(entry.id)
	print("Finished the script")
	return 'success'
