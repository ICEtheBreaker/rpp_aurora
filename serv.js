let a = 5
let b = 7

/**
 * 
 * @param {number} a 
 * @param {number} b 
 * @returns sum
 */
let sum = (a,b) => a + b

let div = document.createElement('div')
div.innerHTML = `Sum is ${sum(a,b)}`
Element.body.appendChild(div)


