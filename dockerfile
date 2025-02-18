FROM python:3.9-slim

WORKDIR /app

COPY ejemplo-py.py /app/

RUN pip install pylint

CMD ["python", "ejemplo-py.py"]