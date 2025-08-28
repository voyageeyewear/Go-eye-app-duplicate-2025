#!/usr/bin/env python3
"""
Simple web server for GoEye app customization sync
"""
import json
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import threading
import time

# Global storage for customization data
customization_data = {}

# Load initial customization data on startup
def load_initial_data():
    global customization_data
    try:
        # Try to load from existing file first
        if os.path.exists('customization_data.json'):
            with open('customization_data.json', 'r') as f:
                data = json.load(f)
                # Check if it's valid customization data (not test data)
                if 'collections' in data or 'showPromotionalBanner' in data:
                    customization_data = data
                    print(f"📂 Loaded existing customization data: {len(customization_data)} items")
                    return
        
        # If no valid data, load from initial file
        if os.path.exists('initial_customization_data.json'):
            with open('initial_customization_data.json', 'r') as f:
                customization_data = json.load(f)
                # Save to main file
                with open('customization_data.json', 'w') as f:
                    json.dump(customization_data, f, indent=2)
                print(f"📂 Loaded initial customization data: {len(customization_data)} items")
        else:
            print("⚠️ No initial customization data found")
    except Exception as e:
        print(f"❌ Error loading customization data: {e}")

# Load data on startup
load_initial_data()

class CustomizationHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed_url = urlparse(self.path)
        path = parsed_url.path
        
        if path == '/health':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({'status': 'healthy'}).encode())
            return
            
        elif path == '/api/customizations':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps(customization_data).encode())
            return
            
        else:
            # Serve static files from build/web directory
            file_path = f'build/web{path}'
            if path == '/':
                file_path = 'build/web/index.html'
            
            if os.path.exists(file_path) and os.path.isfile(file_path):
                self.send_response(200)
                
                # Set content type based on file extension
                if file_path.endswith('.html'):
                    self.send_header('Content-type', 'text/html')
                elif file_path.endswith('.js'):
                    self.send_header('Content-type', 'application/javascript')
                elif file_path.endswith('.css'):
                    self.send_header('Content-type', 'text/css')
                elif file_path.endswith('.json'):
                    self.send_header('Content-type', 'application/json')
                elif file_path.endswith('.png'):
                    self.send_header('Content-type', 'image/png')
                elif file_path.endswith('.jpg') or file_path.endswith('.jpeg'):
                    self.send_header('Content-type', 'image/jpeg')
                elif file_path.endswith('.gif'):
                    self.send_header('Content-type', 'image/gif')
                elif file_path.endswith('.ico'):
                    self.send_header('Content-type', 'image/x-icon')
                else:
                    self.send_header('Content-type', 'application/octet-stream')
                
                self.end_headers()
                
                with open(file_path, 'rb') as f:
                    self.wfile.write(f.read())
            else:
                self.send_response(404)
                self.send_header('Content-type', 'text/plain')
                self.end_headers()
                self.wfile.write(b'File not found')
    
    def do_POST(self):
        parsed_url = urlparse(self.path)
        path = parsed_url.path
        
        if path == '/api/customizations':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            try:
                global customization_data
                customization_data = json.loads(post_data.decode('utf-8'))
                
                # Save to file for persistence
                with open('customization_data.json', 'w') as f:
                    json.dump(customization_data, f, indent=2)
                
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps({'status': 'success'}).encode())
                
                print(f"✅ Customization data updated: {len(customization_data)} items")
                
            except json.JSONDecodeError as e:
                self.send_response(400)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps({'error': 'Invalid JSON'}).encode())
                
        else:
            self.send_response(404)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            self.wfile.write(b'Endpoint not found')
    
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()
    
    def log_message(self, format, *args):
        # Custom logging to show API calls
        if '/api/' in self.path:
            print(f"🌐 API {self.command} {self.path} - {self.address_string()}")
        else:
            # Only log non-API requests occasionally to avoid spam
            if not hasattr(self, '_request_count'):
                self._request_count = 0
            self._request_count += 1
            if self._request_count % 10 == 0:
                print(f"📄 Static file request: {self.path}")

def load_existing_data():
    """Load existing customization data from file if it exists"""
    global customization_data
    try:
        if os.path.exists('customization_data.json'):
            with open('customization_data.json', 'r') as f:
                customization_data = json.load(f)
            print(f"📂 Loaded existing customization data: {len(customization_data)} items")
    except Exception as e:
        print(f"⚠️ Could not load existing data: {e}")

def main():
    load_existing_data()
    
    port = 8082
    server_address = ('0.0.0.0', port)  # Bind to all interfaces
    httpd = HTTPServer(server_address, CustomizationHandler)
    
    print(f"🚀 Starting GoEye customization sync server on port {port}")
    print(f"📱 Mobile app will sync every 5 seconds")
    print(f"🌐 Web app available at: http://localhost:{port}")
    print(f"🔗 API endpoint: http://localhost:{port}/api/customizations")
    print(f"💚 Health check: http://localhost:{port}/health")
    print("=" * 50)
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")
        httpd.server_close()

if __name__ == '__main__':
    main()
