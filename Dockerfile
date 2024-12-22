FROM ubuntu:20.04

# Giảm thiểu dữ liệu không cần thiết
ENV DEBIAN_FRONTEND=noninteractive

# Chỉ cài đặt các thành phần cần thiết
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install flask

COPY app.py /opt/

EXPOSE 5000

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 