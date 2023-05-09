import {JSDOM} from 'jsdom'
const jsdom = new JSDOM('<x>xml</x>',"text/xml")
const DOMParser = jsdom.window.DOMParser
const Node = jsdom.window.Node
const Element = jsdom.window.Element

export {DOMParser, Node, Element}