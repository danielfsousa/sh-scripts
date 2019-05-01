#!/usr/bin/env node

const { Transform } = require('stream')

class FilterLogs extends Transform {
  _lineReducer (acc, line) {
    if (line) {
      const json = JSON.parse(line)
      if (json.level === 'error') {
        acc.push(JSON.stringify(json))
      }
    }

    return acc
  }

  _transform (chunk, encoding, callback) {
    try {
      const jsonChunk = chunk.toString()
        .split('\n')
        .reduce(this._lineReducer, [])
        .join('\n')

      if (jsonChunk) {
        this.push(jsonChunk + '\n')
      }

      callback()
    } catch (err) {
      callback(err)
    }
  }
}

process.on('uncaughtException', err => {
  console.error(`Uncaught exception: ${err.message}`)
  process.exit(1)
})

process.stdin
  .pipe(new FilterLogs())
  .pipe(process.stdout)
