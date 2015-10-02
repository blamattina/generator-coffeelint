# <%= appname %>

> <%= ruleDescription %>

## Installation

1. Setup [CoffeeLint](http://coffeelint.org) in your project and verify that it
   works
2. Add this module as a `devDependency`: `npm install -D <%= appname %>`
3. Update your `coffeelint.json` configuration file as described below.

## Configuration

Add the following snippet to your `coffeelint.json` config:

```json
{
  "<%= ruleUnderscored %>": {
    "module": "<%= appname %>",
    "level": "warn"
  }
}
```
