#!/bin/sh -x

su-exec cerebro java ${JAVA_OPTS} -Duser.dir=/opt/cerebro -cp '' -jar /opt/cerebro/lib/cerebro.cerebro-launcher.jar
