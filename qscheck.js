#!/usr/bin/env node

const { parse } = require('querystring')

const [
  queryString,
  queryStringPropName,
  queryStringExpected,
] = process.argv.slice(2)

if (!queryString || !queryStringPropName || !queryStringExpected) {
  console.error('ERROR! Must pass three args')
  process.exit(1)
}

const actual = parse(queryString)[queryStringPropName]

if (actual === queryStringExpected) {
  console.log(`${actual} is equal to ${queryStringExpected}`)
  process.exit(0)
} else {
  console.log(`${actual} is not equal to ${queryStringExpected}`)
  process.exit(1)
}
