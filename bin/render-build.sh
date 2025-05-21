#!/usr/bin/env bash

# Exit on error
# set -o errexit

# bundle install
# bin/rails assets:precompile
# bin/rails assets:clean

#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec solid_queue database setup
bundle exec rails db:migrate

# If you have a paid instance type, we recommend moving
# database migrations like this one from the build command
# to the pre-deploy command:
# bin/rails db:migrate