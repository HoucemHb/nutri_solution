# ------------------------
# 1. Build Stage
# ------------------------
FROM node:18-slim AS build

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy package files first
COPY package*.json ./

# Install dependencies and fix the css-inline issue
RUN npm ci --verbose && \
    npm install @css-inline/css-inline-linux-x64-gnu --save-optional || true

# Copy source and build
COPY . .
RUN npm run build

# ------------------------
# 2. Production Dependencies Stage
# ------------------------
FROM node:18-slim AS deps

WORKDIR /app

# Copy package files and install production dependencies only
COPY package*.json ./
RUN npm ci --only=production --verbose && \
    npm install @css-inline/css-inline-linux-x64-gnu --save-optional || true && \
    npm cache clean --force

# ------------------------
# 3. Runtime Stage
# ------------------------
FROM node:18-slim AS runtime

# Create non-root user
RUN groupadd -r nodejs && useradd -r -g nodejs nodejs

WORKDIR /app

# Copy production files
COPY --from=deps --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=build --chown=nodejs:nodejs /app/dist ./dist
COPY --chown=nodejs:nodejs package*.json ./

# Create uploads directory
RUN mkdir -p uploads/images uploads/files && \
    chown -R nodejs:nodejs uploads

USER nodejs

EXPOSE 3000
CMD ["node", "dist/main.js"]
