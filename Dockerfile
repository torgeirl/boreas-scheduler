FROM python:3.13-slim AS base
FROM base AS builder

ENV PYTHONPATH=/install/lib/python3.13/site-packages \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_ROOT_USER_ACTION=ignore

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip==26.1 && `# required for --uploaded-prior-to` \
    pip install --uploaded-prior-to P7D --upgrade pip setuptools && \
    pip install --uploaded-prior-to P7D --prefix=/install --no-warn-script-location -r /requirements.txt

FROM base

ENV PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore

RUN apt-get update && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip==26.1 && `# required for --uploaded-prior-to` \
    pip install --uploaded-prior-to P7D --upgrade pip setuptools
COPY --from=builder /install /usr/local
COPY src /app
WORKDIR /app

CMD ["python", "-u", "scheduler.py"]
