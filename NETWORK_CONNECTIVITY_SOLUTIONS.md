# Network Connectivity Solutions for Android Device/Emulator

## Problem
Your Android device/emulator cannot connect to the backend server at `https://j03ps88p-5000.asse.devtunnels.ms/`

Error: `Failed host lookup: 'j03ps88p-5000.asse.devtunnels.ms'`

## Solutions (Try in order)

### Solution 1: Use Your Computer's Local IP (Recommended for Testing)

1. **Find your computer's local IP address:**
   ```bash
   # On Linux
   ip addr show | grep "inet " | grep -v 127.0.0.1
   
   # Or
   hostname -I
   ```
   Example output: `192.168.1.100`

2. **Make sure your backend is listening on 0.0.0.0 (not just localhost)**
   - Check your backend server configuration
   - It should bind to `0.0.0.0:5000` not `localhost:5000`

3. **Update endpoints.dart to use local IP:**
   ```dart
   const String Base_URL = 'http://192.168.1.100:5000/';  // Replace with YOUR IP
   const String Login_Endpoint = 'api/auth/login';
   const String Register_Endpoint = 'api/auth/register';
   ```

4. **Ensure your device/emulator is on the same network:**
   - For physical device: Connect to same WiFi as your computer
   - For Android emulator: Use `10.0.2.2` instead of your local IP:
     ```dart
     const String Base_URL = 'http://10.0.2.2:5000/';
     ```

### Solution 2: Fix DevTunnel Public Access

If you want to keep using the devtunnel URL:

1. **Check if devtunnel allows public access:**
   ```bash
   # When starting the tunnel, use public access:
   devtunnel host -p 5000 --allow-anonymous
   ```

2. **Or use ngrok instead:**
   ```bash
   # Install ngrok from https://ngrok.com/
   ngrok http 5000
   
   # Copy the https URL provided (e.g., https://abc123.ngrok.io)
   # Update endpoints.dart with this URL
   ```

### Solution 3: Configure Android Network Security (if using HTTP)

If using HTTP (not HTTPS), you need to allow cleartext traffic:

1. **Create/Edit** `android/app/src/main/res/xml/network_security_config.xml`:
   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <network-security-config>
       <domain-config cleartextTrafficPermitted="true">
           <domain includeSubdomains="true">10.0.2.2</domain>
           <domain includeSubdomains="true">192.168.1.100</domain>
       </domain-config>
   </network-security-config>
   ```

2. **Reference it in** `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <application
       ...
       android:networkSecurityConfig="@xml/network_security_config"
       android:usesCleartextTraffic="true">
   ```

### Solution 4: Test with a Public API First

To verify your app's network connectivity works:

1. **Temporarily update endpoints.dart to use a test API:**
   ```dart
   const String Base_URL = 'https://jsonplaceholder.typicode.com/';
   const String Login_Endpoint = 'posts/1';
   ```

2. **If this works, your app networking is fine** - the issue is accessing your backend

## Quick Testing Commands

### Test from your computer:
```bash
curl -X POST https://j03ps88p-5000.asse.devtunnels.ms/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'
```

### Test with local IP:
```bash
# First, find your IP
hostname -I

# Then test
curl -X POST http://YOUR_IP:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'
```

### Check if backend is running:
```bash
# In your backend directory
cd LocateLost_Backend
npm start
# or
node src/index.js
```

## Recommended Setup for Local Development

### For Android Emulator:
```dart
// endpoints.dart
const String Base_URL = 'http://10.0.2.2:5000/';
```

### For Physical Android Device:
```dart
// endpoints.dart
const String Base_URL = 'http://192.168.1.100:5000/';  // Your computer's IP
```

### Backend Server (Node.js):
```javascript
// Make sure server listens on 0.0.0.0
app.listen(5000, '0.0.0.0', () => {
  console.log('Server running on http://0.0.0.0:5000');
});
```

## Troubleshooting Checklist

- [ ] Backend server is running
- [ ] Backend is listening on `0.0.0.0` (not just `localhost`)
- [ ] Firewall allows incoming connections on port 5000
- [ ] Device/emulator is on same network as computer
- [ ] Using correct IP address (check with `hostname -I`)
- [ ] If using HTTP, cleartext traffic is allowed in AndroidManifest
- [ ] CORS is enabled on backend for your frontend origin
- [ ] Test API endpoint with curl first before testing in app

## Current Status

✅ Backend is reachable from your development machine (we tested with curl)  
❌ Backend is NOT reachable from Android device/emulator  
🔧 **Next Step**: Update endpoints.dart to use local IP or fix devtunnel public access
