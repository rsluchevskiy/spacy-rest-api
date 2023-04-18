FROM python:3.10.6

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    supervisor \
    curl && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

WORKDIR /app

COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

RUN pip3 install -U pip setuptools wheel
RUN pip3 install -U spacy
RUN python3 -m spacy download en_core_web_trf

EXPOSE 5000

CMD ["python3", "app.py"]
