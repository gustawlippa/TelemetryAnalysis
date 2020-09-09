#!/usr/bin/env bash
docker build -t prometheus-telemetry .
docker volume create prometheus-data
docker run -p 9090:9090 -v prometheus-data:/prometheus prometheus-telemetry
