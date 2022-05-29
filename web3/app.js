const Web3 = require('web3')
const web3 = new Web3();
// import web3 from 'web3';

console.log(111)
console.log(web3)
 
 var http = require('http');

// 서버 생성
var app = http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type':'text/html'});
    res.write(`
    	<script src="https://cdn.jsdelivr.net/gh/ethereum/web3.js@1.0.0-beta.36/dist/web3.min.js" integrity="sha256-nWBTbvxhJgjslRyuAKJHK+XcZPlCnmIAAMixz6EefVk=" crossorigin="anonymous"></script>
    	<script>
    		 window.addEventListener('load', async () => {
    let web3, account;
    // 2
    if (window.ethereum) {
      web3 = new Web3(window.ethereum);
    // 3
    } else if (typeof window.web3 !== 'undefined') {
      web3 = new Web3(window.web3.currentProvider);
    } else {
      // 4
      reject(new Error('No web3 instance injected, using local web3.'))
    }
    if (web3) {
      // 5
      account = await web3.eth.requestAccounts();
    }
  })
    console.log(28282)
    	</script>

    	<h1>Hello Node.js!</h1>
	`);
    res.end();
})

// 서버의 포트넘버 지정
app.listen(3000, function () {
    console.log('Server listens on port number 3000.....');

    
});