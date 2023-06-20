# This should be a fixed version, not a SNAPSHOT
# but we need features from the 7.9 release.
# It would be nice to set this to "latest" -
# that should be the latest release but now it
# is the latest SNAPSHOT. Because of this confusion
# we do not put "latest" here.
FROM nexus.frankframework.org/frank-framework:7.9-SNAPSHOT
ENV TZ=Europe/Amsterdam

COPY --chown=tomcat context.xml /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml
COPY --chown=tomcat src/test/testtool/ /opt/frank/testtool/
COPY --chown=tomcat src/main/configurations/ /opt/frank/configurations/
COPY --chown=tomcat src/main/resources/ /opt/frank/resources/

# Martijn May 2 2023: Copied from ZaakBrug and edited in a trivial way.
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
  CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)