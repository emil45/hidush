from dataclasses import dataclass
import logging
import os
from pathlib import Path
from typing import List

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from contentful import Client, Entry
from google.cloud.firestore_v1 import CollectionReference

SPACE_ID = "1iyxb3e05tph"
CMS_API_KEY = os.environ["CMS_API_KEY"]


@dataclass
class Hidush:
	id: str
	source: str
	sourceDetails: str
	quote: str
	peroosh: str
	rabbi: str
	categories: List[str]


cred = credentials.Certificate(Path(__file__).parent / "serviceAccountKey.json")
firebase_admin.initialize_app(cred, {'projectId': "hidush-1337"})

db = firestore.client()
hidushim_collection: CollectionReference = db.collection('hidushim')

client = Client(space_id=SPACE_ID, access_token=CMS_API_KEY)


def get_entries() -> List[Hidush]:
	entries: List[Entry] = client.entries({'content_type': 'hidush', 'locale': 'he-IL'})
	return [
		Hidush(id=entry.id, quote=entry.quote['content'][0]['content'][0]['value'],
		       peroosh=entry.peroosh['content'][0]['content'][0]['value'],
		       source=entry.source, sourceDetails=entry.source_details, rabbi=entry.rabbi, categories=entry.categories)
		for entry in entries
	]


def upsert_entries(entries: List[Hidush]):
	for entry in entries:
		try:
			if hidushim_collection.document(entry.id).get().exists:
				hidushim_collection.document(entry.id).update(vars(entry))
				print(f"Successfully updated the entry. Entry: {entry.id}")
				logging.info(f"Successfully updated the entry. Entry: {entry.id}")
			else:
				hidushim_collection.add({**vars(entry), 'likes': 0, 'shares': 0}, entry.id)
				print(f"Successfully created new entry. Entry: {entry.id}")
				logging.info(f"Successfully created new entry. Entry: {entry.id}")
		except Exception:
			print(f"Failed to update/create entry. Entry: {entry.id}")
			logging.exception(f"Failed to update/create entry. Entry: {entry.id}")


def main():
	entries = get_entries()
	upsert_entries(entries)


if __name__ == '__main__':
	main()
