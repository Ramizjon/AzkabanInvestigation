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

###Dependencies pipeline

In order to view dependencies pipeline you have to click on flow's name in project's flows list. Graph with job's dependencies will be shown.

![Screenshot 3] (https://s18.postimg.org/m1uvcam1l/Screenshot_at_Aug_29_18_14_59.png)

###Big picture

Azkaban allows users to view whole history of workflows in any type of status. Workflow list is available under "History" section of Azkaban dashboard.

![Screenshot 4] (https://s17.postimg.org/3lzp29kfz/Screenshot_at_Aug_29_18_27_13.png)

You can apply multiple filters on search in order to draw up suitable workflow list (view only failed or succeded jobs etc.)

![Screenshot 5] (https://s17.postimg.org/s7e34rppr/Screenshot_at_Aug_29_18_40_38.png)

In order to re-run **whole failed workflow**, you have to do following:
- Click on it's execution id (first column) in list
- Go to `Prepare execution` section
- Click `execute` button

![Screenshot 6] (https://s18.postimg.org/6ovlifh21/Screenshot_at_Aug_29_18_46_03.png)

If you want to **re-run particular job only**, you have to do following:
- Go to necessary workflow execution
- Go to `Prepare execution` section
- Right click on any of job on the graph and select `disable` -> `disable all` menu item
- Right click on necessary job on the graph and click `enable` menu item
- Click `execute` button

![Screenshot 7] (https://s17.postimg.org/t6llffkhb/Screenshot_at_Aug_29_18_57_50.png)


