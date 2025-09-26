# syntax=docker/dockerfile:1

FROM rust:1-bookworm AS builder

WORKDIR /app

COPY server/Cargo.toml server/Cargo.lock ./
COPY server/src ./src
RUN cargo build --release

FROM debian:bookworm-slim AS runtime

COPY --from=builder /app/target/release/server /usr/local/bin/server

ENV HOST=0.0.0.0 \
    PORT=8080 \
    RUST_LOG=info

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/server"]
