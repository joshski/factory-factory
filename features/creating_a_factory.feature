Feature: Creating a factory

  Scenario: Generating a factory from the command line
    Given the file "adapters/app/app.js" contains:
      """
      module.exports = class App {
        constructor({ db }) { this.db = db }
      }
      """
    And the file "adapters/db/memory.js" contains:
      """
      module.exports = class MemoryDb {
        constructor({ logger }) { this.logger = logger }
      }
      """
    And the file "adapters/db/postgres.js" contains:
      """
      module.exports = class PostgresDb {
        constructor({ logger }) { this.logger = logger }
      }
      """
    And the file "adapters/logger/console.js" contains:
      """
      module.exports = class ConsoleLogger {}
      """
    And the file "adapters/logger/file.js" contains:
      """
      module.exports = class FileLogger {}
      """
    And the file "production.js" contains:
      """
      const factory = require('./factory')

      console.log(factory.buildApp({ db: 'postgres', logger: 'file' }))
      """
    When I run `factory-factory adapters/*/*.js`
    And I run `node production.js`
    Then the output should be:
      """
      App { db: PostgresDb { logger: FileLogger {} } }
      """
