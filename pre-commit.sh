#!/bin/sh

CMD="asciidoctor-pdf -a scripts=cjk -a pdf-theme=default-with-fallback-font -a attribute-missing=warn --failure-level=WARN -D output *.adoc"

if type "asciidoctor-pdf" > /dev/null 2>&1; then
    $CMD
elif type "docker" > /dev/null 2>&1; then
    docker run --rm -v ./docs:/documents/ -v ./output:/documents/output asciidoctor/docker-asciidoctor $CMD
else
    echo "asciidoctor-pdf not found"
    rm *.pdf
    exit 1
fi

if [ $? -ne 0 ]; then
    rm *.pdf
    exit 1
fi
