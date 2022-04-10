const Test = artifacts.require('Test')
const assertRevert = require('./assertRevert')
const expectEvent = require('./expectEvent')
const betAmount = 5 * 10 ** 15
const betBlockInterval = 3
contract('Test', ([deployer, user1, user2] )=>{
    beforeEach( async  ()=>{
        console.log(`each`)
        test = await  Test.new()
    })

    it('팟 값 확인', async ()=>{
        const pot = await test.getPot()
        assert.equal(pot, 0)
    })

    describe(`bet`, ()=>{
        it('베팅 실패', async ()=>{

            await assertRevert(`0xab`, {
                from : user1,
                value:3* 10 ** 15})
            // await test.bet(`0xab`, {
            //     from : user1,
            //     value:3* 10 ** 15})
        })

        it('베팅 성공', async ()=>{
            
            const recipe = await test.bet(`0xab`, {
                from : user1,
                value:betAmount})

            const pot = await test.getPot()
            assert.equal(pot, 0)
            const contractBalance = await web3.eth.getBalance(test.address)
            assert.equal(contractBalance, betAmount)

            const currentBlockNumber = await web3.eth.getBlockNumber()
            const bet = await test.getBetInfo(0)
            assert.equal(bet.answerBlockNumber, currentBlockNumber + betBlockInterval)
            assert.equal(bet.bettor, user1)
            assert.equal(bet.challenges, `0xab`)
        
            await expectEvent.inLogs(recipe.logs, 'BET')
        })
        


    })
})

