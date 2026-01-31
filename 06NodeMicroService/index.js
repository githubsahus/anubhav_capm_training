const express = require('express');
const app = express();
const port = 1000;
app.listen(port, () => {
  console.log(`Microservice running at http://localhost:${port}`);
});

app.use(express.static('webapp'));

app.get('/', (req, res) => {
    res.send('Hello from the Node.js Microservice!');
});