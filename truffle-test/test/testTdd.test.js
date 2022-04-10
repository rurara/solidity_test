const Test = artifacts.require('Test')

contract('Test', ([deployer, user1, user2] )=>{
    beforeEach( async  ()=>{
        console.log(`each`)
        test = await  Test.new()
    })
    it('test :(', async ()=>{
        console.log(`yahoyaho`)
        const owner = await test.owner()
        let some = await test.getSomeValue()

        console.log(`owner ${owner}`)
        console.log(`value ${some}`)

        assert.equal(some, 5)
    })
})