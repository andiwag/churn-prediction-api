# Start from a slim Python base
FROM python:3.12-slim

# Install uv (super fast package installer)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /app

# Copy project metadata first (for caching deps)
COPY pyproject.toml uv.lock ./

# Install deps
RUN uv sync --frozen

# Copy source
COPY src ./src
COPY tests ./tests

# Run as non-root
RUN useradd -m appuser
USER appuser

CMD ["uv", "run", "python", "-m", "app.main"]
