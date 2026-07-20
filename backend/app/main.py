from fastapi import FastAPI

app = FastAPI(
    title="BreachLens API",
    description="AI-powered cloud security scanning platform.",
    version="0.1.0"
)


@app.get("/")
async def root():
    return {
        "message": "Welcome to BreachLens API"
    }


@app.get("/health")
async def health():
    return {
        "status": "healthy"
    }