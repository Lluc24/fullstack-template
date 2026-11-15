from typing import Literal

from fastapi import FastAPI
from pydantic import BaseModel


class HealthResponse(BaseModel):
    status: Literal["ok"]


app = FastAPI(title="App")


@app.get("/v1/health")
def get_health() -> HealthResponse:
    return HealthResponse(status="ok")


app.frontend("/", directory="frontend/dist")
