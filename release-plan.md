# Release plan

## Schedule
- June: discuss the details and build first version.
- July: Improve the first version or build the new version from scratch.
- August: Keep improving and improve test cases.
  - The end of august: release!

## Principle
- Anyone can make their own branch without any permissions.
  - Once you confirmed that your code works, send 'pull request' to the manager.
- Anyone can deploy the master branch to preview environment.
  - Should be deployed as frequently as possible. (Daily is ideal)

## Member(virtual)
- Client: Yosei
- Project manager: ?
  - Designer: ?
  - Coder: ?
  - Tester: ?

## Environment
- https://base.lmlab.net

Preparation for deployment.

```
mkdir /var/www/base
chown ubuntu:ubuntu /var/www/base
apt install nodejs
letsencrypt certonly -d base.lmlab.net
```
