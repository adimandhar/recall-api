from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import requests

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

ITUNES_API = "https://itunes.apple.com/search"

@app.get("/search")
def search(query: str = ""):

    if not query:
        return {"results": []}

    response = requests.get(
        ITUNES_API,
        params={
            "term": query,
            "media": "music",
            "limit": 20
        }
    )

    data = response.json()

    results = []

    for item in data.get("results", []):

        results.append({
            "id": item.get("trackId", 0),
            "title": item.get("trackName", "Unknown"),
            "artist": item.get("artistName", "Unknown"),
            "album": item.get("collectionName", "Unknown"),
            "artwork": item.get("artworkUrl100", ""),
            "preview": item.get("previewUrl", "")
        })

    return {
        "results": results
    }

@app.post("/recognize")
async def recognize(file: UploadFile = File(...)):
    return {
        "title": "Recognized Song",
        "artist": "Unknown Artist"
    }