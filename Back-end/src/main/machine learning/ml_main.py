import uvicorn
from fastapi import FastAPI

from recommendation import app as recommendation_app
from face_comparison import app as face_comparison_app

app = FastAPI()
app.mount("/recommendation", recommendation_app)
app.mount("/face-comparison", face_comparison_app)

uvicorn.run(app, host="localhost", port=4040)
