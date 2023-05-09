import { promises as fsPromise } from 'fs'
import { DOMParser, Node } from './testdom'
import { Deck, Suit, Rank, Card, Seats } from '../src/basics/src/bridge/constants'

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

function holdingCallback(element:Element):string {
    const card = element.getAttribute('card')
    if (card) {
        const rank = Deck.ranks.byName(card)
        // console.log('card',suit.symbol,rank.brief)
        return rank.brief
    }

    const cards = element.getAttribute('cards')
    if (cards) {
        const ranks = Deck.ranks.parse(cards)
        return ranks.map((rank) => rank.brief).join("-")
    }

    return '-'
}

function suitCallBack(suit:Suit, element:Element):string {
    const card = element.getAttribute('card')
    return suit.symbol + ' '+ holdingCallback(element)
}

function ignoreElement(element:Element):string {
    return ''
}

const callbacks = new Map<string,(element:Element) => string>()

Deck.suits.each((suit:Suit) => {
    callbacks.set(suit.singular, (element) => suit.symbol + holdingCallback(element))
})    
callbacks.set('holding',holdingCallback)

callbacks.set('diagram',ignoreElement)

function defaultCallback(element:Element):string {
    let result = ""
    const children = element.childNodes
    for (let i=0; i<children.length; i++) {
        result += toPlainText(children[i])
    }
    return result
}

function toPlainText(node:Node):string {
    if (!node) {
        return ''
    }

    if (node.nodeType == Node.ELEMENT_NODE) {
        const element = node as Element
        //console.log("Element",element.tagName,element.namespaceURI)
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
        const text = toPlainText(body)
        console.log(text)
    })
    return promise
})
    


