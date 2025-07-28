# 1. Use Python 3.10 slim image (matches common torch/transformers wheels)
FROM python:3.10-slim

# 2. Set work directory inside the container
WORKDIR /app

# 3. Copy requirements and wheel packages first (great for build caching)
COPY requirements.txt .
COPY downloaded_packages/ ./downloaded_packages/

# 4. Install all Python dependencies **from local wheels only**
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-index --find-links=downloaded_packages -r requirements.txt

# 5. Copy the rest of your project
COPY . .

# 6. Set entrypoint (runs main.py by default; change if needed)
CMD ["python", "main.py"]
