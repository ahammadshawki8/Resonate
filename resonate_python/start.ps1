# Start Resonate Python AI Service
# PowerShell script for Windows

Write-Host "Starting Resonate Python AI Service..." -ForegroundColor Green

# Check if virtual environment exists
if (-Not (Test-Path "venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
pip install -r requirements.txt

# Download NLTK data
Write-Host "Downloading NLTK data..." -ForegroundColor Yellow
python -c "import nltk; nltk.download('punkt', quiet=True); nltk.download('vader_lexicon', quiet=True)"

# Check for .env file
if (-Not (Test-Path ".env")) {
    Write-Host "WARNING: .env file not found. Copying from .env.example..." -ForegroundColor Yellow
    Copy-Item ".env.example" ".env"
    Write-Host "Please edit .env and add your GROQ_API_KEY" -ForegroundColor Red
}

# Start Flask app
Write-Host "Starting Flask server on port 8001..." -ForegroundColor Green
python app.py
