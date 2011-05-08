require('coffee-script')
"Bot|Local|IRC".split('|').forEach(function(mod) {
  exports[mod] = require('./' + mod.toLowerCase())[mod]
})
