#!/bin/sh

if type "docker" > /dev/null 2>&1; then
    docker run --rm -v ./docs:/documents/ -v ./output:/documents/output asciidoctor/docker-asciidoctor $CMD
    docker run --rm -v ./docs:/documents/ -v ./output:/documents/output asciidoctor/docker-asciidoctor asciidoctor -a scripts=cjk -a pdf-theme=default-with-fallback-font -a attribute-missing=warn --failure-level=WARN -D output *.adoc
    docker run --rm -v ./docs:/documents/ -v ./output:/documents/output pandoc/latex /documents/output/resume.html -o /documents/output/resume.docx
else
    echo "asciidoctor-pdf not found"
    rm ourtput/*.pdf
    rm output/*.docx
    rm output/*.html
    exit 1
fi

if [ $? -ne 0 ]; then
    rm output/*.pdf
    rm output/*.docx
    rm output/*.html
    exit 1
fi
