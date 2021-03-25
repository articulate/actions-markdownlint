FROM node:lts-alpine

COPY entrypoint.sh .github/problem-matcher.json .markdownlint.json /

RUN npm install --global --production markdownlint-cli

ENTRYPOINT ["/entrypoint.sh"]
