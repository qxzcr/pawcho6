const http = require('http');
const os = require('os');
const version = process.env.VERSION || '1.0.0';

const server = http.createServer((req, res) => {
  const ip = req.socket.localAddress || 'unknown';
  const hostname = os.hostname();
  
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <h1>Aplikacja Webowa</h1>
    <p>Adres IP serwera: ${ip}</p>
    <p>Nazwa serwera (hostname): ${hostname}</p>
    <p>Wersja aplikacji: ${version}</p>
  `);
});

server.listen(8080, () => {
  console.log('Serwer działa na porcie 8080');
});