# Flutter App Deployment Guide

## Table of Contents
1. [Flutter Setup](#flutter-setup)
2. [Running on Emulator](#running-on-emulator)
3. [Deploying Web Service](#deploying-web-service)
4. [Deploying Node.js Backend](#deploying-nodejs-backend)

---

## Flutter Setup

### Prerequisites
- Flutter SDK installed
- Android Studio/Xcode (for emulator)
- Node.js (for web deployment)
- Git installed

### Deployment Steps
Deploying Web Service
Build for Production
```bash
flutter build web
Create Deployment Directory
bash
mkdir deploy
cp -r build/web deploy/
cd deploy
Initialize Deployment Repo
bash
git init
git add .
git commit -m "Initial deployment commit"

Create package.json
json
{
  "name": "flutter-web-render",
  "version": "1.0.0",
  "description": "Flutter web app on Render",
  "scripts": {
    "start": "serve -s"
  },
  "dependencies": {
    "serve": "^14.2.0"
  },
  "engines": {
    "node": ">=16.0.0"
  }
}
Deploy on Render
Go to Render Dashboard

Click "New" → "Web Service"

Connect your repository

Leave all settings as default

Click "Deploy"

Access your app at: https://[your-service-name].onrender.com