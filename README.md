# App description

This application aims to help analysts in fish analysis process, by marking and extracting valid nucleus from uploaded images. Nucleus extracted is displayed with some features that can help analysis, like color channel removal, add a processing to remove background and in the future a Neural Network that gives a second opinion if the nucleus is valid or not.

The Neural Network step is going to be implemented during image acquisition and labeling by the analyst that is using the application, so with more labeled images more acute the neural network precision enhances.

At this moment the application is serving only to help analyst in nucleus analysis by providing image processing features.

# Development

To set up development machine run the sequence

 - vagrant up
 - give execution privilege to node_install.sh, ruby_install.sh, rails_install.sh and chrome_install.sh
 - run node_install
 - run ruby_install
 - run rails_install
 - run chrome_install
 - ren redis_install

# Deploy

To deploy application you must run the scripts in deploy dir on file name sequence

After install all apps and setup redis and sidekiq application can be started running script start.sh

# Stack

- Rails 6.0.2
- Ruby 2.6.3
- Postgres
- Redis 5.0.5
- Sidekiq 6
- The core image processing module uses python3 with OpenCV4
