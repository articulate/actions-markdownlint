#!/bin/sh

if [ -n "$INPUT_VERSION" ]; then
    echo "::debug::installing markdownlint-cli ${INPUT_VERSION}"
    npm install --global --production "markdownlint-cli@${INPUT_VERSION}"
fi

# Copy the matcher to a shared volume with the host; otherwise "add-matcher"
# can't find it.
if [ "$INPUT_ANNOTATIONS" != "false" ]; then
    cp /problem-matcher.json "${HOME}/markdownlint-problem-matcher.json"
    echo "::add-matcher::${HOME}/markdownlint-problem-matcher.json"
fi

MARKDOWNLINT=

if [ -z "$INPUT_CONFIG" ]; then
    echo "::debug::no config given, finding suitable config"
    INPUT_CONFIG=/.markdownlint.json
    for cfg in .markdownlint.yaml .markdownlint.yml .markdownlint.json .markdown-lint.yml .markdown-lint.json; do
        if [ -f "$cfg" ]; then
            INPUT_CONFIG="$cfg"
            continue
        fi
    done
fi

echo "::debug::using config ${INPUT_CONFIG}"
MARKDOWNLINT="${MARKDOWNLINT} --config ${INPUT_CONFIG}"

if [ -n "$INPUT_IGNORE" ]; then
    echo "::debug::ignoring ${INPUT_IGNORE}"
    MARKDOWNLINT="${MARKDOWNLINT} --ignore ${INPUT_IGNORE}"
fi

if [ -n "$INPUT_FIX" ]; then
    echo "::debug::attempting to fix input"
    MARKDOWNLINT="${MARKDOWNLINT} --fix"
fi

echo "::debug::linting ${INPUT_FILES}"
# shellcheck disable=SC2086
markdownlint ${MARKDOWNLINT} ${INPUT_FILES}
