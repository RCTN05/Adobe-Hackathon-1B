# Adobe-Hackathon-1B
# Adobe Hackathon Project — Intelligent PDF Analyzer

This project processes PDF documents to extract relevant content and generate personalized summaries based on job-related keywords and personas.

---

## 🧠 Overview

The solution performs the following steps:

1. **Text Extraction:** Extracts text and headings from PDF documents.
2. **Feature Engineering:** Uses `model-1.pkl` (a Random Forest classifier) to identify section headings within the extracted text.
3. **Semantic Relevance:** Applies **SentenceTransformer** to semantically compare extracted headings with keywords related to the "Job To Be Done".
4. **Scoring & Relevance:** Each section is scored based on semantic similarity, and the most relevant ones are selected.
5. **Persona-Based Summary:** A custom summary is generated using the most relevant content, tailored to the given persona.

---

## 📁 Project Structure

project-root/
├── Dockerfile
├── main.py
├── requirements.txt
├── README.md
├── .gitignore
├── models/
│ ├── model-1.pkl # Random Forest classifier
│ └── all-MiniLM-L6-v2/ # SentenceTransformer (download separately)
├── src/
│ ├── extract_text.py
│ ├── feature_engineer.py
│ ├── model_loader.py
│ ├── rank_sections.py
│ ├── relevance.py
│ ├── summarizer.py
│ ├── utils.py
---

## ⚠️ Setup Instructions

> 🚫 No internet access is allowed during runtime.  
> ✅ All dependencies and models must be bundled **locally** before building the Docker image.

### 📥 1. Download SentenceTransformer Locally

This project uses `all-MiniLM-L6-v2` from Hugging Face.

Download it once on a machine with internet:

```python
from sentence_transformers import SentenceTransformer
model = SentenceTransformer('all-MiniLM-L6-v2')
model.save('models/all-MiniLM-L6-v2')
docker build --platform linux/amd64 -t mysolutionname:somerandomidentifier .
Builds the image using your local files

Includes all dependencies and models

Must be run from the project root (where the Dockerfile is)

📂 Step 2: Prepare Input/Output Folders
Create the folders where Docker can read input PDFs and write output JSONs:

bash
Copy
Edit
mkdir input output
Place all your .pdf files inside the input/ folder

Output files will be generated in the output/ folder

🚀 Step 3: Run the Docker Container
bash
Copy
Edit
docker run --rm \
  -v $(pwd)/input:/app/input \
  -v $(pwd)/output:/app/output \
  --network none \
  mysolutionname:somerandomidentifier


