const express = require('express');

const app = express()
const port = 3000


if (true) 
  console.log("test")

if (true) 
  console.log("test")

if (true) 
  console.log("test")

if (true) 
  console.log("test")

if (true) 
  console.log("test")


function func(a) {
  let i = 10;
  return i + a;
  i++; // Noncompliant: this is never executed
}

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

//const queryParams = new URLSearchParams(document.location.search);
//const redirectUrl = queryParams.get("url");
//document.location = redirectUrl; // Noncompliant
