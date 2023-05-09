import {Deck, Seats, Suit, Rank, Card, Seat} from '../basics/src/bridge/constants'

interface ParseContext {
    inParagraph: Boolean
    addCard(c:Card):void 
    addHolding(ranks: Rank[], suit: Suit|undefined):void
}

type ElementCallback = (e: Element, ctx: ParseContext) => void

class ArticleParser {
    readonly elementMap = new Map<string,ElementCallback>()

    determineHolding(element:Element, ctx:ParseContext):string {    
        const cards = element.getAttribute('cards')
        if (cards) {
            const ranks = Deck.ranks.parse(cards)
            return ranks.map((rank) => rank.brief).join("-")
        }
    
        return '-'
    }
    
    suitCallback(suit:Suit, element:Element, ctx:ParseContext):string {
        const card = element.getAttribute('card')
        if (card) {
            const rank = Deck.ranks.byName(card)
            ctx.addCard(rank.of(suit))
        }

        return suit.symbol + ' '+ this.determineHolding(element,ctx)
    }

    constructor() {
        const _this = this
        Deck.suits.each ((suit:Suit) => {
            this.elementMap.set(suit.singular,(e:Element, ctx:ParseContext) => { 
                _this.suitCallback(suit,e,ctx)
            })
        })
    }
}
