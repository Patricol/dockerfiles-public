#!/bin/bash
shopt -s globstar
for filename in /projects/dockerfiles/**/Dockerfile-specific-*; do
    cat ${filename} > ${filename/specific-}
    echo "" >> ${filename/specific-} 
    echo "" >> ${filename/specific-} 
    cat ${filename//-specific-*/} >> ${filename/specific-}
done
shopt -u globstar
