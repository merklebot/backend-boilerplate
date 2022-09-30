FROM python:3.10.6 as requirements-stage
WORKDIR /tmp
RUN pip install poetry
COPY ./pyproject.toml ./poetry.lock* /tmp/
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

FROM python:3.10.6
WORKDIR /backend
COPY --from=requirements-stage /tmp/requirements.txt /backend/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt
COPY backend /backend/backend
CMD ["python", "-m", "backend"]
