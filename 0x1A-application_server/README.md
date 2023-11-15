# Concept: 0x1A. Application server
========================

### Concepts

*For this project, we expect you to look at these concepts:*

-   [Web Server](https://intranet.alxswe.com/concepts/17)
-   [Server](https://intranet.alxswe.com/concepts/67)
-   [Web stack debugging](https://intranet.alxswe.com/concepts/68)


Background Context
------------------

[![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2019/6/2ea1058f813d42c61f48.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20231115%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231115T190049Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=f87e325cdf39a8341d6e2b891fc57e7f034f7b362892090c15f113d9244d91c2)](https://youtu.be/pSrKT7m4Ego)

Our web infrastructure is already serving web pages via `Nginx` that you installed in our [first web stack project](https://intranet.alxswe.com/rltoken/95oRNZ-zRGwLxtWECJqsWA "first web stack project"). While a web server can also serve dynamic content, this task is usually given to an application server. In this project we add this piece to our infrastructure, plug it to our `Nginx` and make it serve our Airbnb clone project.

Resources
---------

**Read or watch**:

-   [Application server vs web server](https://intranet.alxswe.com/rltoken/B9fOBzIxX_t1289WAuRzJw "Application server vs web server")
-   [How to Serve a Flask Application with Gunicorn and Nginx on Ubuntu 16.04](https://intranet.alxswe.com/rltoken/kpG6RwmwRJHzRmGUM_ERcA "How to Serve a Flask Application with Gunicorn and Nginx on Ubuntu 16.04") (As mentioned in the video, do **not** install Gunicorn using `virtualenv`, just install everything globally)
-   [Running Gunicorn](https://intranet.alxswe.com/rltoken/2LF1j7xKJGYaUtD1HKgUeQ "Running Gunicorn")
-   [Be careful with the way Flask manages slash](https://intranet.alxswe.com/rltoken/lEg0zpkkDcLtdl3VD4ACRQ "Be careful with the way Flask manages slash") in [route](https://intranet.alxswe.com/rltoken/Zn8fYk-U9YRm7Z5Coqqb0g "route") - `strict_slashes`
-   [Upstart documentation](https://intranet.alxswe.com/rltoken/cldrneY3Qr7LlDysygzRHw "Upstart documentation")

Tips:

-   Check out these articles/docs for clues on how to configure `Nginx`: [Understanding Nginx Server and Location Block Selection Algorithms](https://intranet.alxswe.com/rltoken/0xFZ6umndhIH19cSGFnexg "Understanding Nginx Server and Location Block Selection Algorithms"), [Understanding Nginx Location Blocks Rewrite Rules](https://intranet.alxswe.com/rltoken/ogjtMopkJjRSToliXzemGQ "Understanding Nginx Location Blocks Rewrite Rules"), [Nginx Reverse Proxy](https://intranet.alxswe.com/rltoken/8O-01TMh2X22EmYNps0X-Q "Nginx Reverse Proxy").
-   In order to spin up a `Gunicorn` instance as a detached process you can use the terminal multiplexer utility `tmux`. Enter the command `tmux new-session -d 'gunicorn --bind 0.0.0.0:5001 web_flask.6-number_odd_or_even:app'` and if successful you should see no output to the screen. You can verify that the process has been created by running `pgrep gunicorn` to see its PID. Once you're ready to end the process you can either run `tmux a` to reattach to the processes, or you can run `kill <PID>` to terminate the background process by ID.
