# AzkabanInvestigation

**AzkabanInvestigation** is a project that performs job's scheduling using Azkaban product.

### Spark flow should include following jobs:
- Launch Spark application. Spark application is executed by using `command` jobtype, that uses `spark-submit` command in order to launch Spark application.
- Load output results of Spark application into Hive table. Hive query is executed by using `hive` jobtype, that references to folder with scripts, that are intended to be executed.
- Extract data from Hive and load it in Vertica database.


### Installation

In order to launch described workflow, you have to install Azkaban and apply some plugins to it.
To install Azkaban solo-server you need:
- Grab the azkaban-exec-server package from the [downloads](http://azkaban.github.io/downloads.html) page.
- Extract the package into a directory.
- Execute `bin/azkaban-solo-start.sh` to start the solo server. 
- Execute `bin/azkaban-solo-shutdown.sh` to shutdown.

To install Hive plugin to you working Azkaban instance you have to:
- Get the azkaban-plugins, either by download the tar ball or check out from Azkaban Github.
- Untar it.
- Place the jobtype "Hive" plugin tar file in 'plugins/jobtypes' directory.
- Restart Azkaban executor service.

After installing all necessary components, create appropriate directory structure, compress it to `.zip` archive and upload to Azkaban via web UI.

In order to schedule workflow, hit `Schedule/Execute flow` button and determine scheduling strategy.

![Screenshot 1] (https://s13.postimg.org/9ykwn719z/Screenshot_at_Aug_23_18_52_34.png)

After successful execution you'll be able to view all stats regarding executed workflow.

![Screenshot 2] (https://s3.postimg.org/o7i2on377/Screenshot_at_Aug_23_18_55_18.png)
