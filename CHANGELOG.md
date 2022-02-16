# v0.5.0 (unreleased)
**Updated dependencies**
- bumped docker base image from `python:3.9-slim` to `python:3.10-slim`
- `kubernetes`: bumped to version 22.6
- removed `pytz`

# v0.4.0 (2021-10-27)
**Updated dependencies**
- `kubernetes`: bumped to version 19.15

**Improvements**
- added scheduler options to adjust pod namespace, allow scheduling of pods without a corresponding `SchedulerName` spec, and provide default CPU and memory resource requests for existing pods

# v0.3.0 (2021-01-21)
**Updated dependencies**
- added `pytz`

**Improvements**
- Scheduler configurations such as batch size are now read from a settings file
- Added optional event warning message when optimizer is unable to find placement (#11)
- Added optional setting that enables passing options to the optimizer
- Worker nodes marked as unschedulable (cordoned) are now ignored when gathering available nodes

# v0.2.0 (2020-11-17)
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
