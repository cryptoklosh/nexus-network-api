ARG version=0.4.8

FROM rust:latest AS build
ARG version
WORKDIR /root
RUN rustup target add riscv32i-unknown-none-elf
RUN apt-get update && \
    apt-get install -y wget build-essential pkg-config libssl-dev protobuf-compiler git curl

COPY . .
WORKDIR /root/clients/cli
RUN cargo build --release
RUN mkdir -p /root/.nexus
RUN rustup target add riscv32i-unknown-none-elf
ENTRYPOINT [ "/root/clients/cli/target/release/nexus-network", "--start", "--beta" ]

# FROM debian:12-slim
# ARG version
# WORKDIR /root
# RUN apt-get update && \
#     apt-get install -y wget curl libssl-dev
# RUN mkdir -p /root/.config/cli
# COPY --from=build /root/clients/cli/target/release /root
# ENTRYPOINT [ "/root/nexus-network", "--start --beta" ]
