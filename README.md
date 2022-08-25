### RUN it 

```
docker build -f Dockerfile.dev -t test-maker:dev .
docker run --rm -p 9292:9292 test-maker:dev
open http://localhost:9292

```
