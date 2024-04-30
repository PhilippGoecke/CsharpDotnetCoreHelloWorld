docker build --no-cache --rm -f Containerfile -t dotnet:demo .
docker run --interactive --tty dotnet:demo
