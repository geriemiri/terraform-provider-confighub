# Terraform Provider ConfiHub

Run the following command to build the provider

```shell
make install
```

## Test sample configuration

First, build and install the provider.

```shell
make install
```

To run proper e2e test, a running ConfigHub instance is required. To start a functioning ConfigHub instance, run the following commands with __docker_compose__ as current directory:

```shell
docker-compose up -d
```

You can login to the ConfigHub by entering https://localhost:8443/ for HTTPS, and http://localhost:8080/ for HTTP. The credentials are as follows:
* Username: test
* Password: testtest

To run the e2e test use the following command at the root of the project:

```shell
make e2e
```