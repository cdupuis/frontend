const path = require('path');
const fs   = require('fs');

function (req, res) {
  const targetDirectory = "/data/app/resources/";
  const userFilename = path.join(targetDirectory, req.query.filename);

  let data = fs.readFileSync(userFilename, { encoding: 'utf8', flag: 'r' }); // Noncompliant
}
 
