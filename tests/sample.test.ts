import { promises as fsPromise } from 'fs'
import { DOMParser, Node } from './dom'
import { Deck, Seats } from '../src/bridge/constants'

async function loadXMLFile():Promise<Document> {
    let contents:XMLDocument|undefined = undefined
    const promise = fsPromise.readFile('./tests/sample.xml','utf-8').then(
        (value) => {
            const parser = new DOMParser()
            console.log(value.slice(0,100))
            contents = parser.parseFromString(value,'application/xml')
        }, 
        (error) => {
         console.log(error)
        }
    )
    await promise
    if (contents) {
        return contents
    }
    throw new Error('Failed to load')
}
function suitCallBack(element:Element):string {
    const suit = element.tagName
    const letter = suit.slice(0,1).toUpperCase()
    console.log('Suit element',suit,letter)
    const card = element.getAttribute('card') ||
                 element.getAttribute('cards')
    if (card) {
        return letter + ' '+ card
    }
    return letter
}

function ignoreElement(element:Element):string {
    return ''
}

const callbacks = new Map<string,(element:Element) => string>()

Deck.suits.each((suit) => {
    callbacks.set(suit.singular,suitCallBack)
})    

callbacks.set('diagram',ignoreElement)

function defaultCallback(element:Element):string {
    let result = ""
    for (let i=0; i<element.childNodes.length; i++) {
        result += toPlainText(element.childNodes[i])
    }
    return result
}

function toPlainText(node:Node):string {
    if (!node) {
        return ''
    }

    if (node.nodeType == Node.ELEMENT_NODE) {
        const element = node as Element
        console.log("Element",element.tagName,element.namespaceURI)
        const callback = callbacks.get(element.tagName) || defaultCallback
        return callback(element)
    } else if (node.nodeType == Node.TEXT_NODE) {
        const text = node as Text
        if (/\S/.test(text.data)) {
            return text.data
        }        
        return '\n'
    }

    return ''
}

const bridgeNS = 'http://www.thomasoandrews.com/xmlns/bridge'
test('Test',()=>{
    const promise = loadXMLFile()
    promise.then((contents) => {
        const topNode = contents.childNodes[0] as Element
        console.log(contents)
        console.log('top node',topNode.nodeName, topNode.namespaceURI)
        expect(contents).toBeDefined()
        const body:Element= topNode.getElementsByTagNameNS(bridgeNS,'body')[0]
        console.log('body',body,body.namespaceURI)
        console.log(toPlainText(body))
    })
    return promise
})
    


