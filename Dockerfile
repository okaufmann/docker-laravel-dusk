FROM php:7.1


# Install chromium and X virtual framebuffer
# https://github.com/mark-adams/docker-chromium-xvfb/blob/master/images/base/Dockerfile
ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

# Install php environment
ADD install.sh /tmp
RUN bash /tmp/install.sh
