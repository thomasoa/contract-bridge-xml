import {promises as fsPromise} from 'fs'

const filePromise = fsPromise.readFile('../public/everybody.xml','utf-8').then(() => {

})

test('Test',()=>{
    expect(1).toBe(0)
})
