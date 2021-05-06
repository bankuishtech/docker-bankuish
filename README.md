# docker v4

## Dockerhub Automatic Builds
Autobuild triggers a new build with every git push to your source code repository. [Learn More](https://docs.docker.com/docker-hub/builds/)

There is a repository in DockerHub under Wenance organization for each Dokerfile/Folder in this repository.
Each DockerHub repository has two automatic builds that generates tags:
1. latest: when you push to master
2. <version> when you push specific tag, that match configured regex for each automatic build

For more information check wenance organization config in DockerHub https://cloud.docker.com/u/wenance/

Builds regex:

| Folder/Dockerfile | version | tag regex |
| ------------- | ------------- | ------------- |
| java-nr  | {\1}  | /^r\/(.*)$/ |
| java-nr-vault  | {\1}  | /^r\/(.*)$/ |
| java-nr-vault-alternative  | {\1}  | /^ra\/(.*)$/ |
| node-nr  | node8.15.0-nr{\1}-alpine-v{\2}  | /^n8-a\/nr(.*)-v(.*)$/ |
| node-nr-vault  | node8.15.0-nr{\1}-vault-alpine-v{\2}  | /^n8-v-a\/nr(.*)-v(.*)$/ |
| python-nr  | python3.6-alpine3.8-nr{\1}-v{\2}  | /^p3.6-a3.8\/nr(.*)-v(.*)$/ |
| python-nr-vault  | python3.6-alpine3.8-nr{\1}-v{\2}  | /^p3.6-a3.8-v\/nr(.*)-v(.*)$/ |
| ruby-chrome-headless-vault | ruby-chrome-headless-vault-v{\1} | /^rb\/v(.*)$/ |
| s3-ftp | {\1} | /^sf\/(.*)$/ |
| solr-nr | solr7.3.1-nr{\1}-alpine-v{\2} | /^s7.3.1-a\/nr(.*)-v(.*)$/ |
| solr-nr-vault | solr7.3.1-nr{\1}-vault-alpine-v{\2} | /^s7.3.1-a-v\/nr(.*)-v(.*)$/ |

Tags examples:
- az/v1.0
- ja/jdk14-alpine-v1.0
- ja/jdk14-alpine-v1.4
- n8-a/nr4.2.0-v1.0
- n8-a/nr4.2.0-v1.1
- n8-v-a/nr4.2.0-v1.0
- n8-v-a/nr4.2.0-v1.1
- n8-v-a/nr4.2.0-v1.2
- p3.6-a3.8-v/nr3.4.0.95-v1.0
- p3.6-a3.8-v/nr3.4.0.95-v1.1
- p3.6-a3.8/nr3.4.0.95-v1.0
- p3.6-a3.8/nr3.4.0.95-v1.1
- p3.6-a3.8/nr3.4.0.95-v1.2
- r/jre8-nr4.1.0-alpine-v1.0.1
- r/jre8-nr4.1.0-alpine-v1.1
- r/jre8-nr4.2.0-alpine-v1.0
- r/jre8-nr4.2.0-alpine-v2.0
- r/jre8-nr4.2.0-alpine-v2.1
- r/jre8-nr4.2.0-alpine-v2.2
- r/jre8-nr4.2.0-alpine-v2.3
- r/jre8-nr4.2.0-alpine-v2.4
- r/jre8-nr4.2.0-alpine-v2.5
- r/jre8-nr4.2.0-alpine-v3.0
- ra/jdk13-nr4.12.1-alpine-v1.0
- ra/jdk13-nr4.12.1-alpine-v1.1
- ra/jdk14-nr4.12.1-alpine-v1.3
- ra/jre8-nr4.12.1-alpine-v1.0
- ra/jre8-nr4.12.1-alpine-v1.4
- ra/jre8-nr4.12.1-alpine-v1.5
- rb/v1.0.2
- rb/v1.0.3
- rb/v1.0.4
- rb/v1.0.5
- s7.3.1-a-v/nr4.2.0-v1.0
- s7.3.1-a/nr4.2.0-v1.0
- sf/0.1.0
- sf/0.2.0
- sf/0.2.1
- sf/0.2.2
- slr7.3.1-a/nr4.2.0-v1.0
- slr7.3.1-a/nr4.2.0-v1.1
# docker
# docker
# docker
# docker
