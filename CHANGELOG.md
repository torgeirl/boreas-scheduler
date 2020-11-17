# v0.2.0 (unreleased)

**Updated dependencies**
- `kubernetes`: bumped to version 12.0
- `trio`: no longer needed with the [introduction of asyncio.to_thread in Python 3.9](https://docs.python.org/3.9/library/asyncio-task.html#running-in-threads)

**Improvements**
- Switched docker base image from `python:3.7-alpine` to `python:3.9-slim`
- Suppressed the stderr log output from `health_server.py` to prevent the constant health checks from clogging up the log for the scheduler container

**Bug fixes**
- Explicit `--prefix=/install` argument in Dockerfile is now passed directly to pip due to deprecation in pip 20.2 ([pypa/pip#7309](https://github.com/pypa/pip/issues/7309))
- Improved workaround for client library failing to deserializing the returned data from namespace binding by skipping deserializing step ([kubernetes-client/python#547](https://github.com/kubernetes-client/python/issues/547))

# v0.1.0 (2019-10-25)
Initial release