#!/bin/sh

ollama serve &

sleep 60

open-webui serve &

bash
