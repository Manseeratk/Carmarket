# Use the official Ruby base image
FROM ruby:2.7

# Set the working directory in the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server when the container is run
CMD ["rails", "server", "-b", "0.0.0.0"]
