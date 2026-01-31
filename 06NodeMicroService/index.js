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

app.get('/api/data', (req, res) => {
    res.json({ message: 'This is some data from the microservice.' });
});