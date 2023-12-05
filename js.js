const path = require('path');
const fs   = require('fs');

function (req, res) {
  const targetDirectory = "/data/app/resources/";
  const userFilename = path.join(targetDirectory, req.query.filename);

  let data = fs.readFileSync(userFilename, { encoding: 'utf8', flag: 'r' }); // Noncompliant
}
 


const queryParams = new URLSearchParams(document.location.search);
const redirectUrl = queryParams.get("url");
document.location = redirectUrl; // Noncompliant

const token = ghp_L8kaXvAddUivKc333333333333333331ZWZe
