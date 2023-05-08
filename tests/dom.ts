import {JSDOM} from 'jsdom'
const jsdom = new JSDOM('<x>xml</x>',"text/xml")
const DOMParser = jsdom.window.DOMParser
const Node = jsdom.window.Node

export {DOMParser, Node}