# Start from a slim Python base
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim


WORKDIR /app

# Copy project metadata first (for caching deps)
COPY pyproject.toml uv.lock ./

# Install deps
RUN uv sync --frozen

# Copy source
COPY src ./src

# Run as non-root
#RUN useradd -m appuser
#USER appuser

# after WORKDIR /app
ENV PYTHONPATH="/app/src"
CMD ["uv", "run", "python", "-m", "app.main"]
