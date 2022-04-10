module.exports = async(prosmise)=>{
	try {
		await prosmise
		assert.fail('실패를 실패')
	} catch(error){
		const revertFound = error.message.search(`show me the`)
		assert(revertFound, `find error ${error}`)
	}
}