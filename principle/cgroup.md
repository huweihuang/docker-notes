# 1. cgroup简介

Linux Cgroup提供了对一组进程及将来子进程的资源限制的能力。资源包括：CPU、内存、存储、网络等。通过Cgroup可以限制某个进程的资源占用，并监控进程的统计信息。

# 2. cgroup示例

1、创建一个hierarchy（cgroup树）

```bash
# 创建一个 hierarchy 挂载点
mkdir cgroup-test 
# 挂载hierarchy 挂载点
mount -t cgroup -o none,name=cgroup-test cgroup-test ./cgroup-test
# 查看生成的默认文件
# ll
总用量 0
-rw-r--r-- 1 root root 0 3月   5 19:13 cgroup.clone_children
--w--w--w- 1 root root 0 3月   5 19:13 cgroup.event_control
-rw-r--r-- 1 root root 0 3月   5 19:13 cgroup.procs
-r--r--r-- 1 root root 0 3月   5 19:13 cgroup.sane_behavior
-rw-r--r-- 1 root root 0 3月   5 19:13 notify_on_release
-rw-r--r-- 1 root root 0 3月   5 19:13 release_agent
-rw-r--r-- 1 root root 0 3月   5 19:13 tasks
```

2、在根cgroup创建2个子cgroup

在cgroup目录下创建目录，子cgroup会继承父cgroup的属性。

```bash
mkdir cgroup-1
mkdir cgroup-2

# tree
.
├── cgroup-1
│   ├── cgroup.clone_children
│   ├── cgroup.event_control
│   ├── cgroup.procs
│   ├── notify_on_release
│   └── tasks
├── cgroup-2
│   ├── cgroup.clone_children
│   ├── cgroup.event_control
│   ├── cgroup.procs
│   ├── notify_on_release
│   └── tasks
├── cgroup.clone_children
├── cgroup.event_control
├── cgroup.procs
├── cgroup.sane_behavior
├── notify_on_release
├── release_agent
└── tasks
```

3、在cgroup中添加和移动进程。

```bash

```

4、通过subsystem限制cgroup中进程的资源。

系统为每个subsystem创建了一个默认的hierarchy，具体如下：

```bash
[root@runtime ~]# ll /sys/fs/cgroup/
总用量 0
drwxr-xr-x 4 root root  0 2月  28 04:48 blkio
lrwxrwxrwx 1 root root 11 2月  28 04:48 cpu -> cpu,cpuacct
lrwxrwxrwx 1 root root 11 2月  28 04:48 cpuacct -> cpu,cpuacct
drwxr-xr-x 5 root root  0 2月  28 04:48 cpu,cpuacct
drwxr-xr-x 2 root root  0 2月  28 04:48 cpuset
drwxr-xr-x 4 root root  0 2月  28 04:48 devices
drwxr-xr-x 2 root root  0 2月  28 04:48 freezer
drwxr-xr-x 2 root root  0 2月  28 04:48 hugetlb
drwxr-xr-x 5 root root  0 2月  28 04:48 memory
drwxr-xr-x 2 root root  0 2月  28 04:48 perf_event
drwxr-xr-x 4 root root  0 2月  28 04:48 pids
drwxr-xr-x 4 root root  0 2月  28 04:48 systemd
```

例如，memor的hierarchy：/sys/fs/cgroup/memory/

```bash
# ll /sys/fs/cgroup/memory/
总用量 0
-rw-r--r--  1 root root 0 2月  28 04:48 cgroup.clone_children
--w--w--w-  1 root root 0 2月  28 04:48 cgroup.event_control
-rw-r--r--  1 root root 0 2月  28 04:48 cgroup.procs
-r--r--r--  1 root root 0 2月  28 04:48 cgroup.sane_behavior
-rw-r--r--  1 root root 0 2月  28 04:48 memory.failcnt
--w-------  1 root root 0 2月  28 04:48 memory.force_empty
-rw-r--r--  1 root root 0 2月  28 04:48 memory.kmem.failcnt
-rw-r--r--  1 root root 0 2月  28 04:48 memory.kmem.limit_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.kmem.max_usage_in_bytes
-r--r--r--  1 root root 0 2月  28 04:48 memory.kmem.slabinfo
-rw-r--r--  1 root root 0 2月  28 04:48 memory.kmem.tcp.failcnt
-rw-r--r--  1 root root 0 2月  28 04:48 memory.kmem.tcp.limit_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.kmem.tcp.max_usage_in_bytes
-r--r--r--  1 root root 0 2月  28 04:48 memory.kmem.tcp.usage_in_bytes
-r--r--r--  1 root root 0 2月  28 04:48 memory.kmem.usage_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.limit_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.max_usage_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.memsw.failcnt
-rw-r--r--  1 root root 0 2月  28 04:48 memory.memsw.limit_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.memsw.max_usage_in_bytes
-r--r--r--  1 root root 0 2月  28 04:48 memory.memsw.usage_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.move_charge_at_immigrate
-r--r--r--  1 root root 0 2月  28 04:48 memory.numa_stat
-rw-r--r--  1 root root 0 2月  28 04:48 memory.oom_control
----------  1 root root 0 2月  28 04:48 memory.pressure_level
-rw-r--r--  1 root root 0 2月  28 04:48 memory.soft_limit_in_bytes
-r--r--r--  1 root root 0 2月  28 04:48 memory.stat
-rw-r--r--  1 root root 0 2月  28 04:48 memory.swappiness
-r--r--r--  1 root root 0 2月  28 04:48 memory.usage_in_bytes
-rw-r--r--  1 root root 0 2月  28 04:48 memory.use_hierarchy
-rw-r--r--  1 root root 0 2月  28 04:48 notify_on_release
-rw-r--r--  1 root root 0 2月  28 04:48 release_agent
drwxr-xr-x 65 root root 0 3月   9 16:11 system.slice
-rw-r--r--  1 root root 0 2月  28 04:48 tasks
drwxr-xr-x  2 root root 0 2月  28 04:48 user.slice
drwxr-xr-x  2 root root 0 2月  28 21:30 YunJing
```

在/sys/fs/cgroup/memory/中创建cgroup，限制进程内存使用。

```bash
cd /sys/fs/cgroup/memory/ && mkdir cgroup-test

# 查看文件
# ll /sys/fs/cgroup/memory/cgroup-test/
总用量 0
-rw-r--r-- 1 root root 0 3月   9 16:28 cgroup.clone_children
--w--w--w- 1 root root 0 3月   9 16:28 cgroup.event_control
-rw-r--r-- 1 root root 0 3月   9 16:28 cgroup.procs
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.failcnt
--w------- 1 root root 0 3月   9 16:28 memory.force_empty
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.kmem.failcnt
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.kmem.limit_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.kmem.max_usage_in_bytes
-r--r--r-- 1 root root 0 3月   9 16:28 memory.kmem.slabinfo
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.kmem.tcp.failcnt
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.kmem.tcp.limit_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.kmem.tcp.max_usage_in_bytes
-r--r--r-- 1 root root 0 3月   9 16:28 memory.kmem.tcp.usage_in_bytes
-r--r--r-- 1 root root 0 3月   9 16:28 memory.kmem.usage_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.limit_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.max_usage_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.memsw.failcnt
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.memsw.limit_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.memsw.max_usage_in_bytes
-r--r--r-- 1 root root 0 3月   9 16:28 memory.memsw.usage_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.move_charge_at_immigrate
-r--r--r-- 1 root root 0 3月   9 16:28 memory.numa_stat
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.oom_control
---------- 1 root root 0 3月   9 16:28 memory.pressure_level
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.soft_limit_in_bytes
-r--r--r-- 1 root root 0 3月   9 16:28 memory.stat
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.swappiness
-r--r--r-- 1 root root 0 3月   9 16:28 memory.usage_in_bytes
-rw-r--r-- 1 root root 0 3月   9 16:28 memory.use_hierarchy
-rw-r--r-- 1 root root 0 3月   9 16:28 notify_on_release
-rw-r--r-- 1 root root 0 3月   9 16:28 tasks
```

5、限制进程资源

拉起测试进程，内存占用为200M

```bash
# stress --vm-bytes 200m --vm-keep -m 1
stress: info: [31581] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd

# ps auxw|grep stress
root     31585 20.6 10.8 214204 204888 pts/1   R+   16:32   0:18 stress --vm-bytes 200m --vm-keep -m 1
# 可见内存使用 204888kB 即204M 

# top -p 31585
  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
31585 root      20   0  214204 204888    124 R 21.3 10.9   0:14.92 stress
```

限制内存

```bash

```





# 3. cgroup常用命令

## 3.1. cgcreate

```bash
$ cgcreate --help
Usage: cgcreate [-h] [-f mode] [-d mode] [-s mode] [-t <tuid>:<tgid>] [-a <agid>:<auid>] -g <controllers>:<path> [-g ...]
Create control group(s)
  -a <tuid>:<tgid>		Owner of the group and all its files
  -d, --dperm=mode		Group directory permissions
  -f, --fperm=mode		Group file permissions
  -g <controllers>:<path>	Control group which should be added
  -h, --help			Display this help
  -s, --tperm=mode		Tasks file permissions
  -t <tuid>:<tgid>		Owner of the tasks file
```

示例：

cpu

```bash
# cgcreate -g cpu:cgrouptest

# ll /sys/fs/cgroup/cpu/cgrouptest
总用量 0
-rw-rw-r-- 1 root root 0 8月  15 20:14 cgroup.clone_children
--w--w---- 1 root root 0 8月  15 20:14 cgroup.event_control
-rw-rw-r-- 1 root root 0 8月  15 20:14 cgroup.procs
-r--r--r-- 1 root root 0 8月  15 20:14 cpuacct.stat
-r--r--r-- 1 root root 0 8月  15 20:14 cpuacct.uptime
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpuacct.usage
-r--r--r-- 1 root root 0 8月  15 20:14 cpuacct.usage_percpu
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpu.cfs_period_us
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpu.cfs_quota_us
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpu.cfs_relax_thresh_sec
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpu.rt_period_us
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpu.rt_runtime_us
-rw-rw-r-- 1 root root 0 8月  15 20:14 cpu.shares
-r--r--r-- 1 root root 0 8月  15 20:14 cpu.stat
-rw-rw-r-- 1 root root 0 8月  15 20:14 notify_on_release
-rw-rw-r-- 1 root root 0 8月  15 20:14 tasks
```

memory

```bash
# cgcreate -g memory:cgrouptest

# ll /sys/fs/cgroup/memory/cgrouptest
总用量 0
-rw-rw-r-- 1 root root 0 8月  15 20:16 cgroup.clone_children
--w--w---- 1 root root 0 8月  15 20:16 cgroup.event_control
-rw-rw-r-- 1 root root 0 8月  15 20:16 cgroup.procs
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.failcnt
--w--w---- 1 root root 0 8月  15 20:16 memory.force_empty
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.kmem.failcnt
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.kmem.limit_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.kmem.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  15 20:16 memory.kmem.slabinfo
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.kmem.tcp.failcnt
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.kmem.tcp.limit_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.kmem.tcp.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  15 20:16 memory.kmem.tcp.usage_in_bytes
-r--r--r-- 1 root root 0 8月  15 20:16 memory.kmem.usage_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.limit_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  15 20:16 memory.meminfo
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.memsw.failcnt
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.memsw.limit_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.memsw.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  15 20:16 memory.memsw.usage_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.move_charge_at_immigrate
-r--r--r-- 1 root root 0 8月  15 20:16 memory.numa_stat
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.oom_control
---------- 1 root root 0 8月  15 20:16 memory.pressure_level
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.soft_limit_in_bytes
-r--r--r-- 1 root root 0 8月  15 20:16 memory.stat
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.swappiness
-r--r--r-- 1 root root 0 8月  15 20:16 memory.usage_in_bytes
-rw-rw-r-- 1 root root 0 8月  15 20:16 memory.use_hierarchy
-r--r--r-- 1 root root 0 8月  15 20:16 memory.vmstat
-rw-rw-r-- 1 root root 0 8月  15 20:16 notify_on_release
-rw-rw-r-- 1 root root 0 8月  15 20:16 tasks
```

## 3.2. cgclassify

```bash
$ cgclassify --help
Usage: cgclassify [[-g] <controllers>:<path>] [--sticky | --cancel-sticky] <list of pids>
Move running task(s) to given cgroups
  -h, --help			Display this help
  -g <controllers>:<path>	Control group to be used as target
  --cancel-sticky		cgred daemon change pidlist and children tasks
  --sticky			cgred daemon does not change pidlist and children tasks
```

# 4. cgroup的目录

`/sys/fs/cgroup/`

```bash
$ ll /sys/fs/cgroup/
总用量 0
drwxr-xr-x 6 root root  0 2月  18 14:31 blkio
lrwxrwxrwx 1 root root 11 2月  18 14:25 cpu -> cpu,cpuacct
lrwxrwxrwx 1 root root 11 2月  18 14:25 cpuacct -> cpu,cpuacct
drwxr-xr-x 6 root root  0 2月  18 14:31 cpu,cpuacct
drwxr-xr-x 4 root root  0 2月  18 14:25 cpuset
drwxr-xr-x 6 root root  0 2月  18 14:31 devices
drwxr-xr-x 4 root root  0 2月  18 14:25 freezer
drwxr-xr-x 4 root root  0 2月  18 14:25 hugetlb
drwxr-xr-x 6 root root  0 2月  18 14:31 memory
drwxr-xr-x 4 root root  0 2月  18 14:25 net_cls
drwxr-xr-x 2 root root  0 2月  18 14:25 oom
drwxr-xr-x 4 root root  0 2月  18 14:25 perf_event
drwxr-xr-x 6 root root  0 2月  18 14:31 pids
drwxr-xr-x 6 root root  0 2月  18 14:25 systemd
```

## 4.1. docker中cgroup目录

### 4.1.1. cpu

`/sys/fs/cgroup/cpu/docker/32a294d870965072acbf544da0c93a1692660d908bd72de43d1da48852083094`

```bash
# ll /sys/fs/cgroup/cpu/docker/32a294d870965072acbf544da0c93a1692660d908bd72de43d1da48852083094
总用量 0
-rw-r--r-- 1 root root 0 7月   8 17:04 cgroup.clone_children
--w--w--w- 1 root root 0 7月   8 17:04 cgroup.event_control
-rw-r--r-- 1 root root 0 7月   8 17:04 cgroup.procs
-r--r--r-- 1 root root 0 7月   8 17:04 cpuacct.stat
-r--r--r-- 1 root root 0 7月   8 17:04 cpuacct.uptime
-rw-r--r-- 1 root root 0 7月   8 17:04 cpuacct.usage
-r--r--r-- 1 root root 0 7月   8 17:04 cpuacct.usage_percpu
-rw-r--r-- 1 root root 0 7月   8 17:04 cpu.cfs_period_us
-rw-r--r-- 1 root root 0 7月   8 17:04 cpu.cfs_quota_us
-rw-r--r-- 1 root root 0 7月   8 17:04 cpu.cfs_relax_thresh_sec
-rw-r--r-- 1 root root 0 7月   8 17:04 cpu.rt_period_us
-rw-r--r-- 1 root root 0 7月   8 17:04 cpu.rt_runtime_us
-rw-r--r-- 1 root root 0 7月   8 17:04 cpu.shares
-r--r--r-- 1 root root 0 7月   8 17:04 cpu.stat
-rw-r--r-- 1 root root 0 7月   8 17:04 notify_on_release
-rw-r--r-- 1 root root 0 7月   8 17:04 tasks
```

### 4.1.2. memory

```bash
# ll /sys/fs/cgroup/memory/docker/32a294d870965072acbf544da0c93a1692660d908bd72de43d1da48852083094
总用量 0
-rw-r--r-- 1 root root 0 7月   8 17:04 cgroup.clone_children
--w--w--w- 1 root root 0 7月   8 17:04 cgroup.event_control
-rw-r--r-- 1 root root 0 7月   8 17:04 cgroup.procs
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.failcnt
--w------- 1 root root 0 7月   8 17:04 memory.force_empty
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.kmem.failcnt
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.kmem.limit_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.kmem.max_usage_in_bytes
-r--r--r-- 1 root root 0 7月   8 17:04 memory.kmem.slabinfo
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.kmem.tcp.failcnt
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.kmem.tcp.limit_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.kmem.tcp.max_usage_in_bytes
-r--r--r-- 1 root root 0 7月   8 17:04 memory.kmem.tcp.usage_in_bytes
-r--r--r-- 1 root root 0 7月   8 17:04 memory.kmem.usage_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.limit_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.max_usage_in_bytes
-r--r--r-- 1 root root 0 7月   8 17:04 memory.meminfo
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.memsw.failcnt
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.memsw.limit_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.memsw.max_usage_in_bytes
-r--r--r-- 1 root root 0 7月   8 17:04 memory.memsw.usage_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.move_charge_at_immigrate
-r--r--r-- 1 root root 0 7月   8 17:04 memory.numa_stat
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.oom_control
---------- 1 root root 0 7月   8 17:04 memory.pressure_level
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.soft_limit_in_bytes
-r--r--r-- 1 root root 0 7月   8 17:04 memory.stat
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.swappiness
-r--r--r-- 1 root root 0 7月   8 17:04 memory.usage_in_bytes
-rw-r--r-- 1 root root 0 7月   8 17:04 memory.use_hierarchy
-r--r--r-- 1 root root 0 7月   8 17:04 memory.vmstat
-rw-r--r-- 1 root root 0 7月   8 17:04 notify_on_release
-rw-r--r-- 1 root root 0 7月   8 17:04 tasks
```

## 4.2. pod中cgroup目录

### 4.2.1. cpu

```bash
#ll /sys/fs/cgroup/cpu/kubepods/burstable/pode90435b5-4673-4bc2-9892-1f4825af5039/f62fb0f76b5b48cf903680296a1ba2abc314fdbf51e023886d06f8470d5ca90d
总用量 0
-rw-r--r-- 1 root root 0 8月  14 15:33 cgroup.clone_children
--w--w--w- 1 root root 0 8月  14 15:33 cgroup.event_control
-rw-r--r-- 1 root root 0 8月  14 15:33 cgroup.procs
-r--r--r-- 1 root root 0 8月  14 15:33 cpuacct.stat
-r--r--r-- 1 root root 0 8月  14 15:33 cpuacct.uptime
-rw-r--r-- 1 root root 0 8月  14 15:33 cpuacct.usage
-r--r--r-- 1 root root 0 8月  14 15:33 cpuacct.usage_percpu
-rw-r--r-- 1 root root 0 8月  14 15:33 cpu.cfs_period_us  #
-rw-r--r-- 1 root root 0 8月  14 15:33 cpu.cfs_quota_us   #
-rw-r--r-- 1 root root 0 8月  14 15:33 cpu.cfs_relax_thresh_sec
-rw-r--r-- 1 root root 0 8月  14 15:33 cpu.rt_period_us
-rw-r--r-- 1 root root 0 8月  14 15:33 cpu.rt_runtime_us
-rw-r--r-- 1 root root 0 8月  14 15:33 cpu.shares   #
-r--r--r-- 1 root root 0 8月  14 15:33 cpu.stat
-rw-r--r-- 1 root root 0 8月  14 15:33 notify_on_release
-rw-r--r-- 1 root root 0 8月  14 15:33 tasks
```

### 4.2.2. memory

```bash
#ll /sys/fs/cgroup/memory/kubepods/burstable/pode90435b5-4673-4bc2-9892-1f4825af5039/f62fb0f76b5b48cf903680296a1ba2abc314fdbf51e023886d06f8470d5ca90d
总用量 0
-rw-r--r-- 1 root root 0 8月  14 15:33 cgroup.clone_children
--w--w--w- 1 root root 0 8月  14 15:33 cgroup.event_control
-rw-r--r-- 1 root root 0 8月  14 15:33 cgroup.procs
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.failcnt
--w------- 1 root root 0 8月  14 15:33 memory.force_empty
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.kmem.failcnt
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.kmem.limit_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.kmem.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  14 15:33 memory.kmem.slabinfo
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.kmem.tcp.failcnt
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.kmem.tcp.limit_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.kmem.tcp.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  14 15:33 memory.kmem.tcp.usage_in_bytes
-r--r--r-- 1 root root 0 8月  14 15:33 memory.kmem.usage_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.limit_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  14 15:33 memory.meminfo
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.memsw.failcnt
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.memsw.limit_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.memsw.max_usage_in_bytes
-r--r--r-- 1 root root 0 8月  14 15:33 memory.memsw.usage_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.move_charge_at_immigrate
-r--r--r-- 1 root root 0 8月  14 15:33 memory.numa_stat
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.oom_control
---------- 1 root root 0 8月  14 15:33 memory.pressure_level
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.soft_limit_in_bytes
-r--r--r-- 1 root root 0 8月  14 15:33 memory.stat
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.swappiness
-r--r--r-- 1 root root 0 8月  14 15:33 memory.usage_in_bytes
-rw-r--r-- 1 root root 0 8月  14 15:33 memory.use_hierarchy
-r--r--r-- 1 root root 0 8月  14 15:33 memory.vmstat
-rw-r--r-- 1 root root 0 8月  14 15:33 notify_on_release
-rw-r--r-- 1 root root 0 8月  14 15:33 tasks
```





参考：

- https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt