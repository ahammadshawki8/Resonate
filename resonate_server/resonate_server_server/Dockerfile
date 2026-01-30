# Use the official Dart image
FROM dart:stable

# Set working directory
WORKDIR /app

# Copy pubspec files and get dependencies first (for Docker cache efficiency)
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the source code
COPY . .

# Build (optional, for serverpod you can run directly)
# RUN dart compile exe bin/main.dart -o bin/server

# Expose the port your server listens on (default 8080)
EXPOSE 8080

# Generate code and apply database migrations before starting the server
RUN dart run serverpod_cli generate
RUN dart run serverpod_cli migrate --apply

# Start the server
CMD ["dart", "bin/main.dart"]
