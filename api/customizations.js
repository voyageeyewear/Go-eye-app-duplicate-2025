// Vercel serverless API for customization data
const fs = require('fs');
const path = require('path');

// In-memory storage (for demo - in production you'd use a database)
let customizationData = {};

// Try to load existing data
const dataFile = path.join(process.cwd(), 'customization_data.json');
try {
  if (fs.existsSync(dataFile)) {
    const data = fs.readFileSync(dataFile, 'utf8');
    customizationData = JSON.parse(data);
  }
} catch (error) {
  console.log('No existing data file found, starting fresh');
}

module.exports = function handler(req, res) {
  // Enable CORS for all origins
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.setHeader('Access-Control-Max-Age', '86400');

  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // Add some basic logging
  console.log(`${req.method} ${req.url} - ${req.headers['user-agent'] || 'Unknown'}`);

  if (req.method === 'GET') {
    console.log('🌐 API GET /api/customizations - Returning data');
    res.status(200).json(customizationData);
    return;
  }

  if (req.method === 'POST') {
    try {
      const newData = req.body;
      customizationData = newData;

      // Save to file (for persistence across deployments)
      try {
        fs.writeFileSync(dataFile, JSON.stringify(customizationData, null, 2));
        console.log('✅ Customization data saved to file');
      } catch (error) {
        console.log('⚠️ Could not save to file:', error.message);
      }

      console.log('✅ Customization data updated:', Object.keys(newData).length, 'items');
      res.status(200).json({ success: true, message: 'Data updated successfully' });
      return;
    } catch (error) {
      console.error('❌ Error updating data:', error);
      res.status(500).json({ error: 'Failed to update data' });
      return;
    }
  }

  res.status(405).json({ error: 'Method not allowed' });
}
