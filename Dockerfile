FROM python:3.9-slim as base
FROM base as builder

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt

RUN pip install --prefix=/install --no-warn-script-location -r /requirements.txt

FROM base

COPY --from=builder /install /usr/local
COPY src /app
WORKDIR /app

CMD ["python", "-u", "scheduler.py"]
