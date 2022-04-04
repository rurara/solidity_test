var express = require('express');
var app = express();
var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.WebsocketProvider('wss://ropsten.infura.io/ws'));
var Tx = require('ethereumjs-tx');

const send_account    = "0x82Ff486364ebDbEe1b34b7538ceD72448d9b38cb";
const receive_account = "0xf2a58d3F268642f7f5416F4248f4Fb2623a5D929";
const privateKey = Buffer.from('privateKey', 'hex');


var solc = require('solc'); //contract Compile
var fs = require('fs'); //file 시스템

app.get('/smartcontract', function(req,res){
  //File Read
  var source = fs.readFileSync("./contracts/HelloWorld.sol", "utf8");

  console.log('transaction...compiling contract .....');
  let compiledContract = solc.compile(source);
  console.log('done!!' + compiledContract);

  var bytecode = '';
  var abi = '';
  for (let contractName in compiledContract.contracts) {
     // code and ABI that are needed by web3
     abi = JSON.parse(compiledContract.contracts[contractName].interface);
     bytecode = compiledContract.contracts[contractName].bytecode; //컨트랙트 생성시 바이트코드로 등록
     // contjson파일을 저장
  }
  console.log(abi);

  const MyContract = new web3.eth.Contract(abi);

  let deploy = MyContract.deploy({
                 data: bytecode,
                 from: send_account}).encodeABI();
  //deploy
  web3.eth.getTransactionCount(send_account, (err, txCount) => {

  const txObject = {
    nonce:    web3.utils.toHex(txCount),
    gasLimit: web3.utils.toHex(1000000), // Raise the gas limit to a much higher amount
    gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
    data : '0x' + deploy
  };

  const tx = new Tx(txObject);
  tx.sign(privateKey);

  const serializedTx = tx.serialize();
  const raw = '0x' + serializedTx.toString('hex');

  web3.eth.sendSignedTransaction(raw)
     .once('transactionHash', (hash) => {
       console.info('transactionHash', 'https://ropsten.etherscan.io/tx/' + hash);
     })
     .once('receipt', (receipt) => {
       console.info('receipt', receipt);
    }).on('error', console.error);
  });

});

//app을 listen
app.listen(4000, function(){
  console.log('Connected BlockChain, 4000 port!');
});