# BUILDER
FROM python:3.14.0-slim-bookworm as builder
LABEL org.opencontainers.image.source="https://github.com/oats-center/ASREC"
ENV PYTHONUNBUFFERED True
WORKDIR /usr/src/app

# Activate virtualenv
RUN python -m venv /opt/venv

# Make sure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"

# Copy requirements and build with pip
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt


# RUNTIME
FROM python:3.14.0-slim-bookworm as runtime
WORKDIR /usr/src/app

# Copy compiled venv from builder
COPY --from=builder /opt/venv /opt/venv

# Make sure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"



# Copy script over and run
COPY watcher.py .
CMD [ "python", "./watcher.py" ]
