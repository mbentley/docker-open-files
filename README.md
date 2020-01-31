# mbentley/open-files

docker image for checking the number of open file descriptors
based off of ubuntu:18.04

To pull this image:
`docker pull mbentley/open-files`

Example usage:

```
docker run -it --rm --privileged --pid=host mbentley/open-files
```

Example output:

```
$ docker run --privileged --pid=host -it --rm  mbentley/open-files
FILES   PID     PROCESS
74016   24168   /usr/bin/mysqld --user=mysql
41310   4373    /opt/tplink/EAPController/jre/bin/java -server -Xms128m -Xmx1024m -XX:MaxHeapFreeRatio=60 -XX:MinHeapFreeRatio=30 -XX:+HeapDumpOnOutOfMemoryError -XX:-UsePerfData -Deap.home=/opt/tplink/EAPController -cp /opt/tplink/EAPController/lib/*: com.tp_link.eap.start.EapLinuxMain
19116   28338   java -jar /usr/share/jenkins/jenkins.war
9805    16835   /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
8342    27042   linux/jre-x64/bin/java -XX:+UnlockExperimentalVMOptions -Xmx1280M -Xss2048k -Dfile.encoding=UTF-8 -Djava.net.preferIPv4Stack=true -Djna.nosys=true -classpath update.jar:ums.jar net.pms.PMS
```
