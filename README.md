# 🧠 Improved ETL Agent

This project contains a privacy-aware, Dockerized ETL (Extract, Transform, Load) pipeline designed for preprocessing industrial datasets like SECOM. It supports outlier removal, imputation, normalization, and optional PII detection using Gemini + Presidio.

---

## 📆 Features

* 📊 Cleans and imputes missing sensor data
* 🔍 Optional PII detection using Microsoft Presidio
* 🔐 Gemini API integration for text redaction
* 🐳 Dockerized for consistency and easy deployment
* ✅ Works with SECOM and other tabular time-series datasets

---

## ⚛️ Step-by-Step Setup

### ♻️ 1. Clone the Repository

```bash
git clone https://github.com/iampruh887/cli-etl-agent.git
cd cli-autoetl-agent
```

---

### 📁 2. Add Your Data Files

Place your CSV files in the following directory:

```bash
cli_autoetl_agent/deploy/data/
```

Example:

```bash
cp /path/to/secom_data.csv ./deploy/data/
cp /path/to/secom_labels.csv ./deploy/data/
```

---

### 🔑 3. Add Your Gemini API Key

1. Copy the sample `.env` file:

```bash
cp deploy/.env.example deploy/.env
```

2. Edit the `.env` file and add your Gemini API key:

```env
GEMINI_API_KEY=your_api_key_here
```

---

### 🐳 4. Install Docker & Docker Compose

If you don’t have them installed:

* [Install Docker](https://docs.docker.com/get-docker/)
* [Install Docker Compose](https://docs.docker.com/compose/install/)

---

### ⚡ 5. Run the Setup Script

```bash
cd deploy
./deploy.sh
```

This script will:

* Create required folders (`data/`, `output/`, `logs/`)
* Ensure `.env` is in place
* Pull the latest Docker image

---

### ▶️ 6. Launch the ETL Agent

Run in interactive mode:

```bash
docker-compose up etl-agent-interactive
```

Once inside the container:

```bash
python improved_etl.py --source /app/data/secom_labels.csv /app/data/secom_data.csv
```

Cleaned output will be saved to:

```
deploy/output/
```

---

## 📁 Folder Structure

```bash
cli_autoetl_agent/
├── improved_etl.py          # Main ETL logic
├── Dockerfile               # Container build file
├── requirements.txt         # Python dependencies
├── deploy/
│   ├── deploy.sh            # Bootstrap script
│   ├── docker-compose.yml   # Compose setup
│   ├── .env.example         # Gemini key template
│   ├── data/                # Place CSV input files here
│   ├── output/              # Output will be saved here
│   └── logs/                # Optional logging
```

---

## 🧰 Optional: Run with Docker Only

You can skip Docker Compose and run the agent directly:

```bash
docker run -it --rm \
  -e GEMINI_API_KEY="your_api_key_here" \
  -v $(pwd)/deploy/data:/app/data:ro \
  -v $(pwd)/deploy/output:/app/output \
  yourdockerhubusername/etl-agent:latest \
  --source /app/data/secom_labels.csv /app/data/secom_data.csv
```

---

## 📋 Requirements

* Docker
* Docker Compose
* Gemini API Key: [https://aistudio.google.com/apikey](https://aistudio.google.com/apikey)


---

## 🤑 License

This project is licensed under the MIT License.

---

## 🧠 Credits

Built with ❤️ by [iampruh887](https://github.com/iampruh887)
