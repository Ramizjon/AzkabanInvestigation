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

##Job configurations

**Runtime properties**

There are properties that are automatically added to Azkaban properties during runtime for a job to use.
These properties include most commonly used variables such as date, time variables, id's etc:
- azkaban.flow.flowid (The flow name that the job is running in)
- azkaban.flow.start.timestamp (The millisecs since epoch start time)
- azkaban.flow.start.month (The start month of the year)
- azkaban.flow.start.day	(The start day of the month)
- azkaban.flow.start.hour(.minute/.second) 
- and others..

**Inherited Parameters**

Any included .properties files will be treated as properties that are shared amongst the individual jobs of the flow. The properties are resolved in a hierarchical manner by directory. It means that .properties files from child directories will inherit parameters from .properties files from upstream directories.

**Parameter substitution**

Azkaban allows for replacing of parameters. Whenever a ${parameter} is found in a properties or job file, Azkaban will attempt to replace that parameter.
Example:

Let's assume we have some .properties file:

    # some.properties
    myparameter=ramizjon

In order to use parameter substitution in .job files use following syntax:

    # my.job
    param1=something
    param2=${myparameter} # will equal "ramizjon"
    

##Comparing Azkaban and Oozie (main differences)

**Supported types of actions out of the box**

- Azkaban: java, javaprocess and pig
- Oozie: mapreduce (java, streaming, pipes), pig, java, filesystem, ssh, sub-workflow, hive, sqoop

**Regular Scheduling**

- Azkaban interval job scheduling is time based
- Oozie interval job scheduling is time & input-data-dependent based

**Parameterization of workflows**
- Azkaban supports variables, i.e.: ${input}
- Oozie supports variables and functions, i.e.: ${fs:dirSize(myInputDir)}

**Runtime**
- Azkaban runs as standalone (one workflows) or server (one user, multi workflows)
- Oozie runs as server (multi user, multi workflows)

**Actions Execute**

- Azkaban, actions run in the Azkaban server as the user running Azkaban
- Oozie, actions run in the Hadoop cluster as the user that submitted the workflow

**Resource Consumption**
- Azkaban holds at least 1 thread per running workflows
- Oozie only uses a thread when the workflows is doing a state transition

**Failover**

- Azkaban, on failure all running workflows are lost
- Oozie, running workflows continue running from their current state

##Personal opinion

After performing investigation of Azkaban, i've got an opinion that using Oozie in conjunction with [Celos](https://github.com/collectivemedia/celos) is more functional. As this bundle is more flexible, supports different types of triggers, not only time-based, more scheduling strategies, more job types out of the box without need to install external plugins, better documentation etc.

However, Azkaban's UI is designed much better, it supports visual representation of workflow as graphs. This let's you directly view even a very large job as a graph, determine which pieces of a complex workflow failed, etc. Moreover, when composing huge workflows from hundreds of actions, XML-based approach, offered by Oozie can confuse with it's huge size. 
