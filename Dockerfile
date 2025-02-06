# This should be a fixed version, not a SNAPSHOT
# but we need features from the 7.9 release.
# It would be nice to set this to "latest" -
# that should be the latest release but now it
# is the latest SNAPSHOT. Because of this confusion
# we do not put "latest" here.
FROM frankframework/frankframework:9.0

# TempFix TODO: Move this to the credentialprovider.properties
ENV credentialFactory.class=nl.nn.credentialprovider.PropertyFileCredentialFactory
ENV credentialFactory.map.properties=/opt/frank/secrets/credentials.properties
ENV TZ=Europe/Amsterdam

COPY --chown=tomcat context.xml /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml
COPY --chown=tomcat src/test/testtool/ /opt/frank/testtool/
COPY --chown=tomcat src/main/configurations/ /opt/frank/configurations/
COPY --chown=tomcat src/main/resources/ /opt/frank/resources/
COPY --chown=tomcat src/main/secrets/ /opt/frank/secrets/

# # Copy dependencies
# COPY --chown=tomcat lib/server/ /usr/local/tomcat/lib/
# COPY --chown=tomcat lib/webapp/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# # Compile custom class, this should be changed to a buildstep in the future
# COPY --chown=tomcat src/main/java /tmp/java
# RUN javac \
#       /tmp/java/nl/nn/adapterframework/parameters/Parameter.java \
#       -classpath "/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*:/usr/local/tomcat/lib/*" \
#       -verbose -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
# RUN rm -rf /tmp/java

# Martijn May 2 2023: Copied from ZaakBrug and edited in a trivial way.
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
  CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)