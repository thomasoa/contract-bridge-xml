import { promises as fsPromise } from 'fs'
import { DOMParser, Node } from './dom'
import { Deck, Suit, Rank, Card, Seats } from '../src/bridge/constants'

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
function suitCallBack(suit:Suit, element:Element):string {
    console.log('Suit element',suit.name)
    const card = element.getAttribute('card')
    if (card) {
        const rank = Deck.ranks.byName(card)
        return suit.symbol + rank.brief
    }

    const cards = element.getAttribute('cards')
    if (cards) {
        const ranks = Deck.ranks.parse(cards)
        return suit.symbol + ranks.map((rank) => rank.brief).join("-")
    }
    return suit.name
}

function ignoreElement(element:Element):string {
    return ''
}

const callbacks = new Map<string,(element:Element) => string>()

Deck.suits.each((suit:Suit) => {
    callbacks.set(suit.singular, (element) => suitCallBack(suit,element))
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
        // console.log("Element",element.tagName,element.namespaceURI)
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
        // console.log(toPlainText(body))
    })
    return promise
})
    


