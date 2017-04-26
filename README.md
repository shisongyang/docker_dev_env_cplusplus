# docker_dev_env_cplusplus
此工程将有几个dockerfile组成。目的是想通过Docker来完成一整套的中文的C++云开发环境。
当前的运行命令如下：
  docker run -d -p 5901:5901 -p 6901:6901 frankshi/dev_vnc_eclipse
然后就可以用vnc 客户端 连接 地址为 IP:5901 初始密码为 ssy123456
网页也可以访问方式如下： http://IP:6901/vnc_auto.html
  
