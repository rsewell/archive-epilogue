# Jenkins

## Configurations

Jenkins runs one server on the swarm node labelled `jenkins_master=true` and
one worker on each node labelled `jenkins_slave=true`.

## Deployment ##

On apollo do:

    git clone git@git-server.otp.ericsson.se:jenkins_scripts.git
    cd jenkins_scripts/jenkins-swarm
    ./start-jenkins

This should build updated images of `jenkins` and `jenkins-swarm-agent`,
push them to artifactory and then restart the cluster.

You need to make sure that no importent jobs are running at the moment before
restarting. For instance you do not want to abort a patch build that someone
needs.

## Development ##

All the jenkins development is done through the `Jenkinsfile`s at the
top level and by configuring the jenkins server to use them.

The `Jenkinsfile`s are written using the Groovy programming language
together with a lot of dsl for Jenkins.

The `Jenkinsfile`s use the [declarative pipelines syntax](https://jenkins.io/doc/book/pipeline/syntax/#declarative-pipeline)
as that syntax allows the best visualization in BlueOcean.

Some useful links are:
* Jenkins Pipeline: https://jenkins.io/doc/book/pipeline/
* Snippet Generator: http://jenkins.otp.ericsson.se:8080/job/otp/pipeline-syntax/
* Steps reference: http://jenkins.otp.ericsson.se:8080/job/otp/pipeline-syntax/html
* Docker/Global variables: http://jenkins.otp.ericsson.se:8080/job/otp/pipeline-syntax/globals
* Groovy: https://groovy-lang.org/documentation.html
* Jenkins API javadoc: https://javadoc.jenkins.io/

## Description

A non-complete listing of the different jobs configured and which files they use.

### OTP Pack and Build

This is the smoke test so that no-one puts broken code into opu.

When: Each time any .gitbranches script is run a new jenkins job is triggered

Files used:
* Jenkinsfile
* scripts/Dockerfile.pack-otp
* scripts/Dockerfile.run-tests
* scripts/Dockerfile.special

Produces:
* `apollo.otp.ericsson.se:5000/i386/otp-master-opu:BUILD_ID`
* `apollo.otp.ericsson.se:5000/otp-master-opu:BUILD_ID`
* `apollo.otp.ericsson.se:5000/otp-docs-master-opu:BUILD_ID`
* `apollo.otp.ericsson.se:5000/otp-special-master-opu:BUILD_ID`

### Windows Build

When: Triggered by `Jenkinsfile` at completion of primary build.

Files used:
* Jenkinsfile.windows
* scripts/build-otp-windows

### Build benchmark

When: Triggered by `Jenkinsfile` at completion of primary build.

Files used:
* Jenkinsfile.benchmark
* scripts/build-otp-benchmarks
* scripts/run-otp-benchmarks

Produces: http requests to monitor for benchmark result update

### OTP Test Runner

When: Once per day or at user trigger

Files used:
* Jenkinsfile.run-otp-tests
* scripts/Dockerfile.pack-otp
* scripts/Dockerfile.run-tests
* scripts/Dockerfile.pack-gcov
* scripts/Dockerfile.run-gcov
* scripts/Dockerfile.pack-valgrind
* scripts/Dockerfile.run-valgrind

Produces: test results put in `/usr/local/otp/tests` and in Monitor/OTP.
