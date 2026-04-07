# ---------- Stage 1: Build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install ALL deps (including dev for build/test if needed)
RUN npm install

# Copy source code
COPY . .

# ---------- Stage 2: Production ----------
FROM node:20-alpine

WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app /app

# Remove dev dependencies
RUN npm prune --production

# Set environment
ENV NODE_ENV=production

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "server.js"]
