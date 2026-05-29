# https://github.com/lambci/docker-lambda#documentation
FROM public.ecr.aws/lambda/provided:al2023-x86_64

ARG RUST_VERSION=1.96.0
RUN dnf install -y jq openssl-devel gcc
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | CARGO_HOME=/cargo RUSTUP_HOME=/rustup sh -s -- -y --profile minimal --default-toolchain $RUST_VERSION
ADD build.sh /usr/local/bin/
VOLUME ["/code"]
WORKDIR /code
ENTRYPOINT ["/usr/local/bin/build.sh"]
